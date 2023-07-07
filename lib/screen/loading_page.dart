import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tft_app/screen/home_page.dart';


/* 로그인시 사용할 로딩 페이지 */
class LoadingPage extends StatefulWidget {
  @override
  _LoadingPage createState() {
    return _LoadingPage();
  }
}

class _LoadingPage extends State<LoadingPage> {
  List<String> user_name = [];
  List<int> user_idx = [];
  List<int> user_points = [];
  List<int> temp_points = [];
  var url = Uri.parse('https://kr.api.riotgames.com/tft/league/v1/challenger');
  Map<String, String> header = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.67",
    "Accept-Language": "ko,en;q=0.9,en-US;q=0.8",
    "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
    "Origin": "https://developer.riotgames.com",
    "X-Riot-Token": "RGAPI-f01ee8a6-2842-4707-b458-265973e7126a",
  };

  Future<void> _API() async {
    http.Response response = await http.get(url, headers: header);
    var user_list = jsonDecode(response.body)['entries'];
    if (user_points.length < 220) {
      for (int i=0; i<user_list.length; i++) {
        bool _isCheck = false;
        if (i==0) {
          user_name.add(user_list[i]['summonerName']);
          user_points.add(user_list[i]['leaguePoints']);
        }
        else {
          for (int j=0; j<i; j++) {
            if (user_points[j] <= user_list[i]['leaguePoints']) {
              user_name.insert(j, user_list[i]['summonerName']);
              user_points.insert(j, user_list[i]['leaguePoints']);
              _isCheck = true;
              break;
            }
          }
          if (_isCheck == false) {
            user_name.add(user_list[i]['summonerName']);
            user_points.add(user_list[i]['leaguePoints']);
          }
        }
        print(i);
      }
    }
    //var reverse = List.from(temp_points.reversed);
    //print(temp_points);
  }
  @override
  Widget build(BuildContext context) {
    _API().then((value) => {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => homePage(
        name_list: user_name, idx_list: user_idx, point_list: user_points,
      )), (route) => false)
    });
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
