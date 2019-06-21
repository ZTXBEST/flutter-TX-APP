import 'package:TXApp/app/app_main_scene.dart';
import 'package:TXApp/common_scene/web_scene.dart';
import 'package:TXApp/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavigatorUtil {
  static void pushPage(
    BuildContext context,
    Widget page, {
    String pageName,
    bool needLogin = false,
  }) {
    if (context == null || page == null || ObjectUtil.isEmpty(pageName)) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushMainPage(
    BuildContext context,
  ) {
    if (context == null) return;
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => RootScene()),
        (Route<dynamic> route) => false);
  }

  static void pushWeb(
    BuildContext context, {
    String title,
    String url,
  }) {
    Navigator.push(
        context,
        new CupertinoPageRoute(
            builder: (ctx) => new WebScene(
                  title: title,
                  url: url,
                )));
  }
}
