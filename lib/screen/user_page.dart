import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tft_app/screen/ranking_page.dart';
import 'package:tft_app/screen/searching_page.dart';
import 'package:tft_app/screen/tool_page.dart';

import 'community_page.dart';
import 'guide_page.dart';
import 'home_page.dart';
import 'meta_page.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key, required this.data, required this.result, required this.region, required this.name_list, required this.point_list, required this.rank_list}) : super(key: key);
  final data;
  final result;
  final region;
  final name_list;
  final point_list;
  final rank_list;
  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  var icon_url;
  List<String> dropList = [
    'KR', 'JP', 'NA', 'BR', 'LAN', 'LAS', 'EUNE', 'EUW', 'TR', 'RU', 'OCE'];
  String selectedValue = 'KR';
  late String id = '';
  DateTime? currentBackPressTime;
  Future<bool> onWillPop(){
    DateTime now = DateTime.now();
    final msg = "뒤로가기 버튼을 한 번 더 누르면 어플리케이션을 종료합니다.";
    Fluttertoast.showToast(msg: msg);
    if(currentBackPressTime == null || now.difference(currentBackPressTime!)
        > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }
  late var percent;
  late var games;
  late String user_tier;
  @override
  Widget build(BuildContext context) {
    icon_url = 'https://ddragon.leagueoflegends.com/cdn/13.13.1/img/profileicon/${widget.data['profileIconId']}.png';
    if (widget.result != 'unknown') {
      user_tier = widget.result['tier'].toLowerCase();
      user_tier = user_tier[0].toUpperCase() + user_tier.substring(1);
      games = widget.result['wins'] + widget.result['losses'];
      percent = (widget.result['wins'] / games * 100).floor();
    }
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        body: WillPopScope(
          onWillPop: onWillPop,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/tft_background.jpg'), // 배경 이미지
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: Text(
                      'TFT.GG',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'title',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.18,
                        height: MediaQuery.of(context).size.width*0.12,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white38,
                          ),
                          color: Colors.black45,
                        ),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.12,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                value: selectedValue,
                                items: dropList.map((String item) {
                                  return DropdownMenuItem<String>(
                                    child: Text(
                                      '${item}',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'contxt',
                                      ),
                                    ),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (dynamic value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10,),
                        width: MediaQuery.of(context).size.width*0.60,
                        height: MediaQuery.of(context).size.width*0.12,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white38,
                          ),
                          color: Colors.black45,
                        ),
                        child: TextField(
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '소환사 검색',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                          ),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'contxt',
                          ),
                          onChanged: (value) {
                            id = value;
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.23-40,
                        height: MediaQuery.of(context).size.width*0.12,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.white38,
                          ),
                          color: Colors.black45,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => searchingPage(
                                  id: id, region: selectedValue, name_list: widget.name_list, point_list: widget.point_list,
                              )), (route) => false);
                            },
                            child: Icon(
                                Icons.search,
                                size: 24
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white38,
                    ),
                    color: Colors.black45,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => homePage(
                              name_list: widget.name_list, point_list: widget.point_list,
                            )), (route) => false);
                          },
                          child: Text(
                            '홈',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => metaPage(
                              name_list: widget.name_list, point_list: widget.point_list,
                            )), (route) => false);
                          },
                          child: Text(
                            '메타 트렌드',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => guidePage(
                              name_list: widget.name_list, point_list: widget.point_list,
                            )), (route) => false);
                          },
                          child: Text(
                            '게임 가이드',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => rankPage(
                              name_list: widget.name_list, point_list: widget.point_list,
                            )), (route) => false);
                          },
                          child: Text(
                            '랭킹',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => toolPage(
                              name_list: widget.name_list, point_list: widget.point_list,
                            )), (route) => false);
                          },
                          child: Text(
                            '배치툴',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => commuPage(
                              name_list: widget.name_list, point_list: widget.point_list,
                            )), (route) => false);
                          },
                          child: Text(
                            '커뮤니티',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '테스트',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '테스트',
                            style: TextStyle(
                              fontFamily: 'contxt',
                              color: Colors.white38,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left:15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      icon_url,
                                      width: MediaQuery.of(context).size.width*0.15,
                                      height: MediaQuery.of(context).size.width*0.15,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.15,
                                      child: Text(
                                        '${widget.data['summonerLevel']}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'contxt',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.data['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'contxt',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      widget.region,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'contxt',
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        widget.result == 'unknown' ?
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/unrank.png',
                                    width: MediaQuery.of(context).size.width*0.25,
                                    height: MediaQuery.of(context).size.width*0.25,
                                  ),
                                  Text(
                                    'Unranked',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'contxt',
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: (MediaQuery.of(context).size.width-50) / 2 - 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '게임 수',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        LinearProgressIndicator(
                                          value: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: (MediaQuery.of(context).size.width-50) / 2 - 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'TOP 4 비율',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        LinearProgressIndicator(
                                          value: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ) :
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/'+ widget.result['tier'].toLowerCase() +'.png',
                                    width: MediaQuery.of(context).size.width*0.25,
                                    height: MediaQuery.of(context).size.width*0.25,
                                  ),
                                  Text(
                                    user_tier + ' ' + widget.result['rank'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'contxt',
                                      color: Colors.white54,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: (MediaQuery.of(context).size.width-50) / 2 - 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '게임 수',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                            Text(
                                              '${games}',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        LinearProgressIndicator(
                                          value: 1,
                                          color: Colors.white10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    width: (MediaQuery.of(context).size.width-50) / 2 - 5,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'TOP 4 비율',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                            Text(
                                              '${percent} %',
                                              style: TextStyle(
                                                fontFamily: 'contxt',
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 2),
                                        LinearProgressIndicator(
                                          value: percent/100,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left:15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                        Text('최근 게임 순위'),
                        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.065,
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.rank_list.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width * 0.07,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: widget.rank_list[index] == 1 ?
                                      Color(0xffAF9500) :
                                      (widget.rank_list[index] == 2 ? Color(0xffB4B4B4) :
                                      (widget.rank_list[index] == 3 ? Color(0xffAD8A56) :
                                      (widget.rank_list[index] == 4 ? Colors.blueGrey :
                                      Colors.white24))),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '#${widget.rank_list[index]}',
                                      style: TextStyle(
                                        fontFamily: 'contxt',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}