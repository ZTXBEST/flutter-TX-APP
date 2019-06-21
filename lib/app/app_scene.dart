import 'package:flutter/material.dart';
import 'package:TXApp/public.dart';
import 'package:TXApp/app/app_guide_scene.dart';
 
class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TXApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xffeeeeee),
        scaffoldBackgroundColor: TXColor.paper,
        textTheme: TextTheme(body1: TextStyle(color: TXColor.darkGray))
      ),
      home: GuideScene(),
    );
  }
}