import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:TXApp/public.dart';

class HomeBanner extends StatefulWidget {
  final List<String> imgList;
  HomeBanner(this.imgList);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner>
    with AutomaticKeepAliveClientMixin {
  int _current = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print(this.widget.imgList);
    if (this.widget.imgList.length == 0) {
      return SizedBox();
    }

    return GestureDetector(
      onTap: () {
        print('点击banner');
      },
      child: new Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: CarouselSlider(
              viewportFraction: 1.0,
              aspectRatio: 2.0,
              autoPlay: true,
              pauseAutoPlayOnTouch: Duration(milliseconds: 400),
              enlargeCenterPage: false,
              items: this.widget.imgList.map<Widget>((url) {
                return Image.network(
                  url,
                  width: ScreenUtil.getScreenW(context),
                  height: ScreenUtil.getScreenW(context) * 0.58,
                  fit: BoxFit.cover,
                );
              }).toList(),
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
          ),
          Positioned(
            right: 15,
            bottom: 20,
            child: Row(
              
            ),
          ),
        ],
      ),
    );
  }
}
