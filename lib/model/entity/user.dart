import 'package:flutter_html/html_parser.dart';

class User{
  String username;
  String password;

  User htmlToUser(String data){
    User user = new User();
    try{
      var html = HtmlParser.parseHTML(data);
      html.getElementsByClassName("123");
    }catch(e){
      print('解析异常');
    }
    return user;
  }
}