class SplashModel {
  String title;
  String content;
  String url;
  String imgUrl;

  SplashModel.fromJson(Map data){
    title = data['title'];
    content = data['content'];
    url = data['url'];
    imgUrl = data['imgUrl'];
  }
}