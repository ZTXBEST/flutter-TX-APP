import 'package:TXApp/my/my_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TXApp/public.dart';

class RootScene extends StatefulWidget {
  @override
  _RootSceneState createState() => _RootSceneState();
}

class _RootSceneState extends State<RootScene> {
  int _tabIndex = 0;
  bool isFinishSetup = false;
  PageState pageState = PageState.Loading;

  List<Image> _tabImages = [
    Image.asset('img/tab_comic_home_n.png'),
    Image.asset('img/tab_video_home_n.png'),
    Image.asset('img/tab_book_home_n.png'),
    Image.asset('img/tab_mine_n.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('img/tab_home_comic_p.png'),
    Image.asset('img/tab_video_home_p.png'),
    Image.asset('img/tab_book_home_p.png'),
    Image.asset('img/tab_mine_p.png'),
  ];

  @override
  void initState() {
    super.initState();
    setupApp();
  }

  setupApp() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      pageState = PageState.Success;
    });
    setState(() {
      isFinishSetup = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isFinishSetup) {
      return LoadingIndicator(
        pageState,
      );
    }
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomeScene(),
          VideoScene(),
          ReaderScene(),
          MyScene(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: TXColor.primary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getIcon(0)),
          BottomNavigationBarItem(icon: getIcon(1)),
          BottomNavigationBarItem(icon: getIcon(2)),
          BottomNavigationBarItem(icon: getIcon(3)),
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  Image getIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}
