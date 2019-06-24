import 'package:TXApp/models/splashModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:TXApp/utils/tx_color.dart';
import 'package:TXApp/public.dart';

class GuideScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GuideSceneState();
}

class GuideSceneState extends State<GuideScene> {
  List<Map> guideList = [
    {'imgName': 'img/guide1.png', 'title': "动漫陪你每一个夜晚"},
    {'imgName': 'img/guide2.png', 'title': "同你去往每个地方"},
    {'imgName': 'img/guide3.png', 'title': "懂你，更懂你所爱"},
    {'imgName': 'img/guide4.png', 'title': "因为在意，所以用心"},
  ];

  List<Widget> guideWidgets = [];

  SplashModel _splashModel = SplashModel.fromJson({
    'title': 'Flutter',
    'content': 'Flutter',
    'url': 'https://www.jianshu.com',
    'imgUrl': 'http://pic37.nipic.com/20140113/8800276_184927469000_2.png',
  });

  int status = 0; // 0、启动页 1、引导页 2、广告页
  int _count = 5; // 广告页倒计时
  TimerUtil _timer;

  @override
  void initState() {
    super.initState();
    _initAsycn();
  }

  void _goMain() {
    NavigatorUtil.pushMainPage(context);
  }

  void _initAsycn() async {
    await SpUtil.getInstance();
    if (SpUtil.getBool(Constant.key_guide, defValue: true) &&
        ObjectUtil.isNotEmpty(guideList)) {
      SpUtil.putBool(Constant.key_guide, false);
      _initBannerData();
    } else {
      _initSplash();
    }
  }

  void _initSplash() {
    setState(() {
      status = 2;
    });
    _timer = new TimerUtil(mTotalTime: 3 * 1000);
    _timer.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_count == 0) {
        _goMain();
      }
    });
    _timer.startCountDown();
  }

  void _initBannerData() {
    setState(() {
      status = 1;
    });
    for (var i = 0; i < guideList.length; i++) {
      if (i == guideList.length - 1) {
        guideWidgets.add(Stack(
          children: <Widget>[
            Image.asset(
              guideList[i]['imgName'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Text(
                guideList[i]['title'],
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 50),
                child: GestureDetector(
                  onTap: () {
                    _goMain();
                  },
                  child: Container(
                    width: 185,
                    height: 48,
                    alignment: Alignment.center,
                    child: Text(
                      '立即启程',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Color(0X19FFFFFF),
                      border: Border.all(width: 1, color: Colors.white70),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
      } else {
        guideWidgets.add(Stack(
          children: <Widget>[
            Image.asset(
              guideList[i]['imgName'],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: Text(
                guideList[i]['title'],
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ));
      }
    }
  }

  Widget _buildLanuchImage() {
    return new Image.asset(
      'img/guide1.png',
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  Widget _buildAdressWidget() {
    if (_splashModel == null) {
      return new Container(
        height: 0.0,
      );
    }
    return new Offstage(
      offstage: !(status == 2),
      child: new InkWell(
          onTap: () {
            if (ObjectUtil.isEmpty(_splashModel)) return;
            _goMain();
            NavigatorUtil.pushWeb(context,
                url:
                    'https://github.com/ZTXBEST',
                title: 'Github');
          },
          child: new Stack(
            children: <Widget>[
              new Container(
                alignment: Alignment.center,
                child: new CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: _splashModel.imgUrl,
                  placeholder: (context, url) => _buildLanuchImage(),
                  errorWidget: (context, url, error) => _buildLanuchImage(),
                ),
              ),
              new Align(
                alignment: Alignment.topRight,
                child: new Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: new GestureDetector(
                    onTap: () {
                      _goMain();
                    },
                    child: new Container(
                      padding: EdgeInsets.all(12),
                      child: new Text(
                        '跳过 $_count',
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      decoration: new BoxDecoration(
                          color: Color(0x66000000),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: new Border.all(
                              width: 0.33, color: TXColor.divider)),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: !(status == 0),
            child: _buildLanuchImage(),
          ),
          new Offstage(
            offstage: !(status == 1),
            child: ObjectUtil.isEmptyList(guideWidgets)
                ? _buildLanuchImage()
                : new Swiper(
                    autoStart: false,
                    circular: false,
                    indicator: CircleSwiperIndicator(
                      radius: 2,
                      spacing: 4,
                      padding: EdgeInsets.only(bottom: 32),
                      itemColor: Colors.white,
                      itemActiveColor: TXColor.primary,
                    ),
                    children: guideWidgets,
                  ),
          ),
          new Offstage(
            offstage: !(status == 2),
            child: _buildAdressWidget(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }
}
