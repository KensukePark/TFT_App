import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class searchingPage extends StatefulWidget {
  const searchingPage({Key? key, required this.id}) : super(key: key);
  final id;
  @override
  State<searchingPage> createState() => _searchingPageState();
}

class _searchingPageState extends State<searchingPage> {
  String file_loc = 'assets/api_key.txt';
  String keys = '';
  var puuid;
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
    var url = Uri.parse('https://kr.api.riotgames.com/tft/summoner/v1/summoners/by-name/' + widget.id);
    Map<String, String> header = {
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.67",
      "Accept-Language": "ko,en;q=0.9,en-US;q=0.8",
      "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
      "Origin": "https://developer.riotgames.com",
      "X-Riot-Token": keys,
    };
    Future<void> _API() async {
      http.Response response = await http.get(url, headers: header);
      puuid = jsonDecode(response.body)['puuid'];

    }
    _API().then((value) => {
      print(puuid),
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
