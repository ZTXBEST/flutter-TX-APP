import 'package:TXApp/widget/FrameAnimationImage.dart';
import 'package:flutter/material.dart';
import 'package:TXApp/public.dart';

class LoadingIndicator extends StatefulWidget {
  final PageState pageState;

  final Retry retry;

  LoadingIndicator(this.pageState, {this.retry});

  @override
  LoadingIndicatorState createState() => LoadingIndicatorState();
}

class LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildStateLayout() {
    Widget widget;
    switch (this.widget.pageState) {
      case PageState.Success:
        widget = Container();
        break;
      case PageState.Loading:
        widget = GestureDetector(
            child: FrameAnimationImage(),
            onTap: () {
              if (this.widget.retry != null) {
                this.widget.retry();
              }
            });
        break;
      case PageState.LoadingNetError:
        widget = GestureDetector(
            onTap: () {
              if (this.widget.retry != null) {
                this.widget.retry();
              }
            },
            child: Container(
              color: TXColor.white,
              child: Text("加载失败，请检查网络",
                  style: TextStyle(
                      color: TXColor.darkGray,
                      fontSize: 16,
                      decoration: TextDecoration.none)),
              width: ScreenUtil.getScreenW(context),
              height: ScreenUtil.getScreenH(context),
              alignment: Alignment.center,
            ));
        break;
      case PageState.LoadingError:
        widget = GestureDetector(
            onTap: () {
              if (this.widget.retry != null) {
                this.widget.retry();
              }
            },
            child: Container(
              color: TXColor.white,
              child: Text("加载失败，点击重试",
                  style: TextStyle(
                      color: TXColor.darkGray,
                      fontSize: 16,
                      decoration: TextDecoration.none)),
              width: ScreenUtil.getScreenW(context),
              height: ScreenUtil.getScreenH(context),
              alignment: Alignment.center,
            ));
        break;
      case PageState.Empty:
        widget = GestureDetector(
            onTap: () {
              if (this.widget.retry != null) {
                this.widget.retry();
              }
            },
            child: Container(
              color: TXColor.white,
              child: Text("暂无数据",
                  style: TextStyle(
                      color: TXColor.darkGray,
                      fontSize: 16,
                      decoration: TextDecoration.none)),
              width: ScreenUtil.getScreenW(context),
              height: ScreenUtil.getScreenH(context),
              alignment: Alignment.center,
            ));
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return buildStateLayout();
  }
}

enum PageState {
  Success, // 加载成功
  Loading, // 加载中
  Empty, // 空
  LoadingNetError, // 网络错误
  LoadingError, // 加载异常
}

typedef Retry = void Function();
