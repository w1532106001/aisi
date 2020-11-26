import 'package:flutter_html/html_parser.dart';

class Model{
  String cover;
  String name;
  String clickNum;
  String downNum;
  String url;
  String introduction;

  static List<Model> htmlToModelList(String data){
    var modelList = <Model>[];
    Model model;
    try{
      var html = HtmlParser.parseHTML(data);
      var lis = html.getElementsByClassName("model")[0].querySelectorAll('li');
      lis.forEach((element) {
        model = new Model();
        var aList = element.querySelectorAll("a");
        String cover = aList[0].querySelector('img').attributes['src'];
        model.cover = cover;
        model.name = aList[1].text;
        model.url = aList[1].attributes['href'];
        var text = element.text;
        print(text);
        model.clickNum = text.substring(text.indexOf('热度：')+3,text.indexOf('下载')-2).trim();
        model.downNum = text.substring(text.indexOf('下载')+3).trim();
        modelList.add(model);
      });
    }catch(e){
      print('解析异常');
    }
      return modelList;
  }
}