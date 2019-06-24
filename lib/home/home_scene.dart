import 'package:TXApp/request/request.dart';
import 'package:TXApp/widget/loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:TXApp/public.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:TXApp/home/home_banner.dart';

class HomeScene extends StatefulWidget {
  HomeScene({Key key}) : super(key: key);
  @override
  _HomeSceneState createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> {
  bool loading = false;
  PageState pageState = PageState.Loading;

  List<String> banner = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    loading = true;
    try {
      await Future.delayed(Duration(milliseconds: 2000), () {
        pageState = PageState.Success;
      });

      var responese = await Request.get(action: 'home_comic');
      print(responese);

      banner.clear();
      responese['banner'].forEach((data) {
        banner.add(data);
      });

      setState(() {
        this.loading = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomeBanner(banner),
    );
  }
}
