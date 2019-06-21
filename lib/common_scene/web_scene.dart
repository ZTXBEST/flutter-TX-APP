
import 'package:TXApp/public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class WebScene extends StatefulWidget {
  final String url;
  final String title;

  WebScene({@required this.url, this.title});

  @override
  _WebSceneState createState() => _WebSceneState();
}

class _WebSceneState extends State<WebScene> {

  bool loading = true;
  PageState pageState = PageState.Loading;

  @override
  void initState() { 
    super.initState();
    fetchData();
  }

  Future fetchData() async{
    await Future.delayed(Duration(milliseconds: 2000),() {
      pageState = PageState.Success;
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (loading) {
      return LoadingIndicator(pageState);
    }

    return WebviewScaffold(
       url: this.widget.url,
       appBar: AppBar(
         title: Text(this.widget.title ?? '腾讯动漫'),
         actions: <Widget>[
           GestureDetector(
            onTap: () {
              Share.share('https://github.com');
            },
            child: Image.asset('img/icon_menu_share.png'),
          ),
         ],
       ),
    );
  }
}