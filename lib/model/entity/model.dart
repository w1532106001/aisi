import 'package:aisi/model/entity/pictures_set.dart';
import 'package:flutter_html/html_parser.dart';

class Model {
  String cover;
  String name;
  String clickNum;
  String downNum;
  String url;
  String introduction;
  int page;
  List<PicturesSet> picturesSetList;

  static List<Model> htmlToModelList(String data) {
    var modelList = <Model>[];
    Model model;
    try {
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
        model.clickNum = text
            .substring(text.indexOf('热度：') + 3, text.indexOf('下载') - 2)
            .trim();
        model.downNum = text.substring(text.indexOf('下载') + 3).trim();
        modelList.add(model);
      });
    } catch (e) {
      print('解析异常');
    }
    return modelList;
  }

  static Model htmlToModel(String data) {
    Model model = new Model();
    try {
      var html = HtmlParser.parseHTML(data);
      var hd1 = html.getElementsByClassName('hd1')[0];
      model.cover = hd1
          .getElementsByClassName('mphoto')[0]
          .querySelector('img')
          .attributes['src'];
      var mmsg = hd1.getElementsByClassName('mmsg')[0];
      model.name = mmsg.children[2].text.trim();
      var mmsgText = mmsg.text.trim();
      model.name = mmsgText.substring(mmsgText.indexOf("模特姓名：")+5,mmsgText.indexOf("模特介绍：")).trim();
      model.introduction = mmsgText.substring(mmsgText.indexOf("模特介绍：")+5,mmsgText.indexOf("模特热度：")).trim();
      model.clickNum = mmsgText.substring(mmsgText.indexOf("模特热度：")+5,mmsgText.indexOf("点击")).trim();
      model.downNum = mmsgText.substring(mmsgText.indexOf("总共下载：")+5).replaceAll('次', '').trim();
      var pageElement = html.querySelector('div.page.ps').text;
      RegExp r = RegExp(r'共\w+页');
      var pageString = r
          .allMatches(pageElement)
          .toList()[0];
      model.page = int.tryParse(
          pageString.group(0).replaceAll("共", '').replaceAll("页", '').trim());

      var lis =
          html.getElementsByClassName('paihan fl')[0].querySelectorAll('li');
      model.picturesSetList = [];
      PicturesSet picturesSet;
      lis.forEach((element) {
        picturesSet = new PicturesSet();
        picturesSet.cover = element.querySelector('img').attributes['src'];
        var aElement = element.querySelectorAll('a')[1];
        picturesSet.name = aElement.text;
        picturesSet.url = aElement.attributes['href'];
        picturesSet.clickNum = int.tryParse(element.text
            .substring(
                element.text.indexOf('浏览：') + 3, element.text.lastIndexOf('下载'))
            .replaceAll('次', '')
            .trim());
        picturesSet.downNum = int.tryParse(element.text
            .substring(element.text.lastIndexOf('下载') + 2,
                element.text.lastIndexOf('次'))
            .trim());
        picturesSet.updateTime = element.text
            .substring(element.text.lastIndexOf('更新时间：') + 5)
            .trim();
        model.picturesSetList.add(picturesSet);
      });
    } catch (e) {
      print('解析异常');
    }
    return model;
  }

  static List<PicturesSet> parsePicturesSetList(String data) {
    List<PicturesSet> picturesSetList = [];
    try {
      var html = HtmlParser.parseHTML(data);
      var lis =
          html.getElementsByClassName('paihan fl')[0].querySelectorAll('li');
      PicturesSet picturesSet;
      lis.forEach((element) {
        picturesSet = new PicturesSet();
        picturesSet.cover = element.querySelector('img').attributes['src'];
        var aElement = element.querySelectorAll('a')[1];
        picturesSet.name = aElement.text;
        picturesSet.url = aElement.attributes['href'];
        picturesSet.clickNum = int.tryParse(element.text
            .substring(
                element.text.indexOf('浏览：') + 3, element.text.lastIndexOf('下载'))
            .replaceAll('次', '')
            .trim());
        picturesSet.downNum = int.tryParse(element.text
            .substring(element.text.lastIndexOf('下载') + 2,
                element.text.lastIndexOf('次'))
            .trim());
        picturesSet.updateTime = element.text
            .substring(element.text.lastIndexOf('更新时间：') + 5)
            .trim();
        picturesSetList.add(picturesSet);
      });
    } catch (e) {
      print('解析异常');
    }
    return picturesSetList;
  }
}
