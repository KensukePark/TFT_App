import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tft_app/screen/community_page.dart';
import 'package:tft_app/screen/guide_page.dart';
import 'package:tft_app/screen/home_page.dart';
import 'package:tft_app/screen/ranking_page.dart';

class metaPage extends StatefulWidget {
  const metaPage({Key? key, required this.name_list, required this.point_list}) : super(key: key);
  final name_list;
  final point_list;
  @override
  State<metaPage> createState() => _metaPageState();
}

class _metaPageState extends State<metaPage> {
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
  @override
  Widget build(BuildContext context) {
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
                                    child: Text('${item}',
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
                              //print(widget.point_list.length);
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
                              color: Colors.white,
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
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute (builder: (BuildContext context) => rankPage(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
