import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScene extends StatelessWidget {
  const HomeScene({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
         '首页'
       ),
       alignment: Alignment.center,
    );
  }
}

