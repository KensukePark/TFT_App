import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
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
  String file_loc = 'assets/api_key.txt';
  String keys = '';
  var enc_id;
  var icon;
  var user_data;
  var result;
  var match_list;
  var doubleup_rank = [];
  var turbo_rank = [];
  List<int> rank_list = [];
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
  @override
  Widget build(BuildContext context) {
    var encoded_id = Uri.encodeComponent(widget.id);
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
    Future<void> _API() async {
      http.Response response = await http.get(url, headers: header);
      enc_id = jsonDecode(response.body)['id'];
      icon = jsonDecode(response.body)['profileIconId'];
      user_data = jsonDecode(response.body);
    }
    Future<void> _API_2() async {
      http.Response response = await http.get(url2, headers: header);
      if (jsonDecode(response.body).length == 0) {
        result = 'unknown';
      }
      else {
        result = jsonDecode(response.body)[0];
      }
    }
    Future<void> _API_3() async {
      http.Response response = await http.get(url3, headers: header);
      if (jsonDecode(response.body).length == 0) {
        match_list = [];
      }
      else {
        match_list = jsonDecode(response.body);
      }
    }
    Future<void> _API_4() async {
      if (match_list.length == 0) {
        rank_list = [];
      }
      else {
        for (int i=0; i<match_list.length; i++) {
          url4 = Uri.parse('https://asia.api.riotgames.com/tft/match/v1/matches/' + match_list[i]);
          http.Response response = await http.get(url4, headers: header);
          for (int j=0; j<8; j++) {
            if (jsonDecode(response.body)['info']['participants'][j]['puuid'] == user_data['puuid']) {
              var rank_temp = jsonDecode(response.body)['info']['participants'][j]['placement'];
              rank_list.add(rank_temp);
              break;
            }
          }
        }
      }
    }
    Future<void> _API_5() async { //더블업, 초고속모드 랭크정보 수집
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
          print(match_list),
          _API_4().then((value) => {
            print(rank_list),
            url5 = Uri.parse('https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/' + enc_id),
            _API_5().then((value) => {
              print(turbo_rank),
              print(doubleup_rank),
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => userPage(
                result: result,
                data: user_data,
                region: widget.region,
                name_list: widget.name_list,
                point_list: widget.point_list,
                rank_list: rank_list,
                doubleup_rank: doubleup_rank,
                turbo_rank: turbo_rank,
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
