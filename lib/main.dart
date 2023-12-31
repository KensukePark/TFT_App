import 'package:flutter/material.dart';
import 'package:tft_app/screen/home_page.dart';
import 'package:tft_app/screen/loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'spoqa',
      ),
      home: LoadingPage(),
    );
  }
}