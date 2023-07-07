import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key, required this.name_list, required this.idx_list, required this.point_list}) : super(key: key);
  final name_list;
  final idx_list;
  final point_list;
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var f = NumberFormat('###,###,###,###');
  String file_loc = 'assets/api_key.txt';
  String? keys;
  List<String> dropList = [
    'KR', 'JP', 'NA', 'BR', 'LAN', 'LAS', 'EUNE', 'EUW', 'TR', 'RU', 'OCE'];
  String selectedValue = 'KR';
  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }
  List<int> temp = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  late String api = '';
  late String id = '';
  @override
  Widget build(BuildContext context) {
    loadAsset(file_loc).then((value) {
      setState(() {
        api = value;
      });
    });
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                            List<int> Temp = List.from(widget.point_list);
                            print(Temp);
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
                        onPressed: () {},
                        child: Text(
                          '홈',
                          style: TextStyle(
                            fontFamily: 'contxt',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '메타 트렌드',
                          style: TextStyle(
                            fontFamily: 'contxt',
                            color: Colors.white38,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '게임 가이드',
                          style: TextStyle(
                            fontFamily: 'contxt',
                            color: Colors.white38,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '랭킹',
                          style: TextStyle(
                            fontFamily: 'contxt',
                            color: Colors.white38,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          '배치툴',
                          style: TextStyle(
                            fontFamily: 'contxt',
                            color: Colors.white38,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        '소환사 랭킹',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'contxt',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.width*0.08,
                              width: MediaQuery.of(context).size.width*0.10,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white38,
                                ),
                                color: Colors.black45,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '#',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'contxt',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width*0.08,
                              width: MediaQuery.of(context).size.width*0.5,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white38,
                                ),
                                color: Colors.black45,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '소환사명',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'contxt',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width*0.08,
                              width: MediaQuery.of(context).size.width*0.15,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white38,
                                ),
                                color: Colors.black45,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '티어',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'contxt',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width*0.08,
                              width: MediaQuery.of(context).size.width*0.20,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white38,
                                ),
                                color: Colors.black45,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'LP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'contxt',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.width*0.08,
                                  width: MediaQuery.of(context).size.width*0.10,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white38,
                                    ),
                                    color: Colors.black45,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${index+1}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'contxt',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.width*0.08,
                                  width: MediaQuery.of(context).size.width*0.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white38,
                                    ),
                                    color: Colors.black45,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.name_list[index],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'contxt',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.width*0.08,
                                  width: MediaQuery.of(context).size.width*0.15,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white38,
                                    ),
                                    color: Colors.black45,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/Challenger.png', height: 25, width: 30,),
                                          Text(
                                            'C',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'contxt',
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.width*0.08,
                                  width: MediaQuery.of(context).size.width*0.20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.white38,
                                    ),
                                    color: Colors.black45,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        f.format(widget.point_list[index]) + ' LP',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'contxt',
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: 10,
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
