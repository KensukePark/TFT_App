import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:tft_app/screen/user_page.dart';

class searchingPage extends StatefulWidget {
  const searchingPage({Key? key, required this.id, required this.region, required this.name_list, required this.point_list}) : super(key: key);
  final id;
  final region;
  final name_list;
  final point_list;
  @override
  State<searchingPage> createState() => _searchingPageState();
}

class _searchingPageState extends State<searchingPage> {
  String file_loc = 'assets/api_key.txt'; //API KEY 파일 위치
  String keys = ''; //Riot API 키
  var enc_id; //유저 암호화 ID
  var icon; //유저 소환사 아이콘 코드
  var user_data; //
  var result; //일반 모드 랭크 정보
  var match_list; //최근 경기 정보
  var doubleup_rank = []; //더블업 모드 랭크 정보
  var turbo_rank = []; //초고속 모드 랭크 정보
  List<int> rank_list = []; //최근 경기 등수
  var trait = []; //최근 경기 특성
  var queue = []; //최근 경기 게임 모드
  var eli_time = []; //최근 경기 플레이 타임
  var when = []; //최근 경기 날짜
  var unit = []; //최근 경기 사용 유닛
  var item = []; //최근 경기 사용 아이템

  /*
  함수명 _loadData
  기능 : API 키 로드 함수
  */
  void _loadData() async {
    final _loadedData = await rootBundle.loadString('assets/api_key.txt');
    setState(() {
      keys = _loadedData;
    });
  }
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  /*
  함수명 : readTimestamp
  기능 : 유닉스 시간을 실제 시간으로 변환하는 함수
  */
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';
    if (diff.inDays == 0) {
      if (diff.inHours == 0) {
        time = diff.inMinutes.toString() + '분 전';
      }
      else time = diff.inHours.toString() + '시간 전';
    }
    else {
      time = diff.inDays.toString() + '일 전';
    }
    return time;
  }
  @override
  Widget build(BuildContext context) {
    var encoded_id = Uri.encodeComponent(widget.id); //암호화된 소환사 이름
    var url = Uri.parse('https://kr.api.riotgames.com/tft/summoner/v1/summoners/by-name/' + encoded_id);
    var url2;
    var url3;
    var url4;
    var url5;
    Map<String, String> header = {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.67",
      "Accept-Language": "ko,en;q=0.9,en-US;q=0.8",
      "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
      "Origin": "https://developer.riotgames.com",
      "X-Riot-Token": keys,
    };
    /*
    함수명 : _API
    기능 : 소환사 정보 로드 함수
    */
    Future<void> _API() async {
      http.Response response = await http.get(url, headers: header);
      enc_id = jsonDecode(response.body)['id'];
      icon = jsonDecode(response.body)['profileIconId'];
      user_data = jsonDecode(response.body);
    }
    /*
    함수명 : _API_2
    기능 : 솔로 랭크 정보 로드 함수
    */
    Future<void> _API_2() async {
      http.Response response = await http.get(url2, headers: header);
      if (jsonDecode(response.body).length == 0) {
        result = 'unknown';
      }
      else {
        result = jsonDecode(response.body)[0];
      }
    }
    /*
    함수명 : _API_3
    기능 : 최근 경기의 ID를 로드
    */
    Future<void> _API_3() async {
      http.Response response = await http.get(url3, headers: header);
      if (jsonDecode(response.body).length == 0) {
        match_list = [];
      }
      else {
        match_list = jsonDecode(response.body);
      }
    }
    /*
    함수명 : _API_4
    기능 : 최근 경기 정보 로드
    */
    Future<void> _API_4() async {
      if (match_list.length == 0) {
        rank_list = [];
      }
      else {
        for (int i=0; i<match_list.length; i++) {
          url4 = Uri.parse('https://asia.api.riotgames.com/tft/match/v1/matches/' + match_list[i]);
          http.Response response = await http.get(url4, headers: header);
          when.add(readTimestamp(jsonDecode(response.body)['info']['game_datetime']));
          for (int j=0; j<8; j++) {
            if (jsonDecode(response.body)['info']['participants'][j]['puuid'] == user_data['puuid']) {
              var rank_temp = jsonDecode(response.body)['info']['participants'][j]['placement'];
              var temp = {}; //특성 정보 임시 저장
              for (int k=0; k<jsonDecode(response.body)['info']['participants'][j]['traits'].length; k++) {
                if (jsonDecode(response.body)['info']['participants'][j]['traits'][k]['style'] < 1) continue;
                temp[jsonDecode(response.body)['info']['participants'][j]['traits'][k]['name']] = jsonDecode(response.body)['info']['participants'][j]['traits'][k]['style'];
              }
              var temp_2 = []; //기물 정보 임시 저장
              var temp_3 = []; //아이템 정보 임시 저장
              for (int l=0; l<jsonDecode(response.body)['info']['participants'][j]['units'].length; l++) {
                var champ_name = jsonDecode(response.body)['info']['participants'][j]['units'][l]['character_id'];
                if (champ_name.length > 10 && champ_name.substring(5,9) == 'Ryze') champ_name = 'TFT9_Ryze';
                var champ_tier = jsonDecode(response.body)['info']['participants'][j]['units'][l]['tier'];
                var temp_final = [champ_name, champ_tier];
                //temp_2.add([champ_name, champ_tier]);
                var temp_4 = [];
                if (jsonDecode(response.body)['info']['participants'][j]['units'][l]['itemNames'].length != 0) {
                  for (int m=0; m<jsonDecode(response.body)['info']['participants'][j]['units'][l]['itemNames'].length; m++) {
                    temp_final.add(jsonDecode(response.body)['info']['participants'][j]['units'][l]['itemNames'][m]);
                  }
                }
                temp_2.add(temp_final);
              }
              print('유닛 시작');
              print(temp_2);
              print('유닛 엔드');
              unit.add(temp_2);
              Map sorted_temp = Map.fromEntries(temp.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
              trait.add(sorted_temp);
              rank_list.add(rank_temp);
              var time_temp = jsonDecode(response.body)['info']['participants'][j]['time_eliminated'].floor();
              eli_time.add('${time_temp~/60}:${time_temp%60}');
              //item.add(temp_3);
              break;
            }
          }
          if (jsonDecode(response.body)['info']['queue_id'] == 1090) queue.add('노말');
          else if (jsonDecode(response.body)['info']['queue_id'] == 1100) queue.add('랭크');
          else if (jsonDecode(response.body)['info']['queue_id'] == 1130) queue.add('초고속');
          else if (jsonDecode(response.body)['info']['queue_id'] == 1160) queue.add('더블업');
          else if (jsonDecode(response.body)['info']['queue_id'] == 1180) queue.add('영혼의 결투');
        }
      }
    }
    /*
    함수명 : _API_5
    기능 : 더블업, 초고속모드 랭크 정보 수집
    */
    Future<void> _API_5() async {
      http.Response response = await http.get(url5, headers: header);
      if (jsonDecode(response.body).length == 0) {
        doubleup_rank.add('unrank');
        turbo_rank.add('unrank');
      }
      else {
        for (int i=0; i < jsonDecode(response.body).length; i++) {
          if ( jsonDecode(response.body)[i]['queueType'] == 'RANKED_TFT_TURBO' ) {
            turbo_rank.add(jsonDecode(response.body)[i]['tier']);
            turbo_rank.add(jsonDecode(response.body)[i]['rank']);
            turbo_rank.add(jsonDecode(response.body)[i]['leaguePoints']);
          }
          else if ( jsonDecode(response.body)[i]['queueType'] == 'RANKED_TFT_DOUBLE_UP' ) {
            doubleup_rank.add(jsonDecode(response.body)[i]['tier']);
            doubleup_rank.add(jsonDecode(response.body)[i]['rank']);
            doubleup_rank.add(jsonDecode(response.body)[i]['leaguePoints']);
          }
        }
      }
      if (doubleup_rank.length == 0) doubleup_rank.add('unrank');
      if (turbo_rank.length == 0) turbo_rank.add('unrank');
    }
    _API().then((value) => {
      url2 = Uri.parse('https://kr.api.riotgames.com/tft/league/v1/entries/by-summoner/' + enc_id),
      _API_2().then((value) => {
        url3 = Uri.parse('https://asia.api.riotgames.com/tft/match/v1/matches/by-puuid/' + user_data['puuid'] +'/ids?start=0&count=10'),
        _API_3().then((value) => {
          _API_4().then((value) => {
            url5 = Uri.parse('https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/' + enc_id),
            _API_5().then((value) => {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => userPage(
                result: result,
                data: user_data,
                region: widget.region,
                name_list: widget.name_list,
                point_list: widget.point_list,
                rank_list: rank_list,
                doubleup_rank: doubleup_rank,
                turbo_rank: turbo_rank,
                trait: trait,
                queue: queue,
                eli_time: eli_time,
                when: when,
                unit: unit,
                item: item,
              )), (route) => false),
            }),
          }),
        }),
      }),
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/tft_background.jpg'), // 배경 이미지
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
            ),
          ),
          child: Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 80.0,
            ),
          ),
        ),
      ),
    );
  }
}
