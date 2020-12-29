import 'package:flutter/material.dart';
// import 'package:/practice/tabs.dart';
// import 'package:practice/home.dart';
import 'package:practice/screen/tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutterTabs',
      home: Tabs(),
    );
  }
}
