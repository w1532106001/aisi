import 'package:aisi/model/entity/model.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/html_parser.dart';

class PicturesSet{
  String cover;
  String name;
  int quantity;
  String fileSize;
  String updateTime;
  int clickNum;
  int downNum;
  String associationName;
  String associationUrl;
  String url;
  String modelName;
  String modelUrl;
  List<String> thumbnailUrlList = [];
  List<String> originalImageUrlList = [];

  static List<PicturesSet> htmlToPicturesSetList(String data){
    var picturesSetList = <PicturesSet>[];
    PicturesSet picturesSet;
    try{
      var html = HtmlParser.parseHTML(data);
      var cells = html.getElementsByClassName("lbl");
      cells.forEach((element) {
        picturesSet = new PicturesSet();
        String cover = element.querySelector("div.ll > a > img").attributes['src'];
        picturesSet.cover = cover;
        var rightBox = element.getElementsByClassName("lr")[0];
        var h4a = rightBox.querySelector("h4 > strong > a");
        picturesSet.url = h4a.attributes['href'];
        picturesSet.name = h4a.text;
        var pList = element.querySelectorAll("p");
        pList.forEach((element) { 
          if(element.outerHtml.contains("张")){
           var quantity = element.text.substring(element.text.indexOf("共有")+2,element.text.indexOf("张"));
           var fileSize = element.text.substring(element.text.indexOf("大小")+2);
           picturesSet.quantity = int.tryParse(quantity.trim());
           picturesSet.fileSize = fileSize.trim();
          }
          if(element.outerHtml.contains("更新时间")){
            var updateTime = element.querySelector('span').text;
            picturesSet.updateTime = updateTime.trim();
          }
          if(element.outerHtml.contains("次")){
            var spans = element.querySelectorAll('span');
            var clickNum = spans[0].text.trim().replaceAll('次', '');
            var downNum = spans[1].text.trim().replaceAll('次', '');
            picturesSet.clickNum = int.tryParse(clickNum.trim());
            picturesSet.downNum = int.tryParse(downNum.trim());
          }
          if(element.outerHtml.contains("隶属")){
            var a = element.querySelectorAll('a');
            var associationName = a[0].text;
            var associationUrl = a[0].attributes['href'];
            picturesSet.associationName = associationName.trim();
            picturesSet.associationUrl = associationUrl.trim();
            if(a.length>1){
              picturesSet.modelName = a[1].text.trim();
              picturesSet.modelUrl = a[1].attributes['href'].trim();
            }
          }
        });
        picturesSetList.add(picturesSet);
      });
    }catch(e){
      print('解析异常');
    }
    return picturesSetList;
  }

  // ignore: missing_return
   PicturesSet parsePicturesSetUrl(String data) {
    try{
      var html = HtmlParser.parseHTML(data);
      var hd3 = html.getElementsByClassName('hd3')[0];
      var gr = hd3.getElementsByClassName('gr');
      if(gr.length>0 && gr[0].text.indexOf('的所有')!=-1){
        this.modelName = gr[0].text.substring(0,gr[0].text.indexOf('的所有')-3);
        this.modelUrl = gr[0].attributes['href'];
      }

      var time = hd3.text.substring(hd3.text.indexOf('发布时间：')+5).trim();
      if(time.isNotEmpty){
        this.updateTime = time;
      }

      this.thumbnailUrlList.clear();
      this.originalImageUrlList.clear();

      //保存当前第一页的图片
      var lis = html.querySelectorAll('div.gtps.fl > ul > li');
      lis.forEach((element) {
        this.thumbnailUrlList.add(element.querySelector('img').attributes['src']);
      });

      var aArray = html.getElementsByClassName('page ps')[0].querySelectorAll('a');
      var totalPage = int.tryParse(
          aArray[aArray.length-3].text.trim());

        var params = DataHelper.getBaseMap();
      Future.sync(HttpManager.getInstance()
          .get(url.replaceAll('.html', '') +'_'+ 2.toString() + ".html", params)).whenComplete(() =>
          print('complete'));

      // Future.sync<String>(HttpManager.getInstance()
      //     .get(url.replaceAll('.html', '') +'_'+ 2.toString() + ".html", params)).then((value) =>
      //     print(value)
      // ).catchError((e){
      //   print(e);
      // });

      // if(totalPage>1){
      //   var params = DataHelper.getBaseMap();
      //   for(int i = 2;i<=totalPage;i++){
      //   Future.sync(HttpManager.getInstance()
      //       .get(url +'_'+ i.toString() + ".html", params)).then((value) =>
      //       print(value)
      //   ).catchError((e){
      //     print(e);
      //     });
      //  }
      // }



      // for (int i = 1; i <= quantity; i++) {
      //   this.thumbnailUrlList.add(thumbnailUrlTemplate+i.toString()+".jpg");
      //   this.originalImageUrlList.add(originalImageUrlTemplate+i.toString()+".jpg");
      //   print(originalImageUrlTemplate+i.toString()+".jpg");
      // }
    }catch(e){
      print('解析异常'+e);
    }
    return this;
  }

   parsePicturesSet(url) async{
    var params = DataHelper.getBaseMap();
    var response = await HttpManager.getInstance().get(url, params);
    try{
    var html = HtmlParser.parseHTML(response);
    var hd3 = html.getElementsByClassName('hd3')[0];
    var gr = hd3.getElementsByClassName('gr');
    if(gr.length>0 && gr[0].text.indexOf('的所有')!=-1){
      this.modelName = gr[0].text.substring(0,gr[0].text.indexOf('的所有')-3);
      this.modelUrl = gr[0].attributes['href'];
    }

    var time = hd3.text.substring(hd3.text.indexOf('发布时间：')+5).trim();
    if(time.isNotEmpty){
      this.updateTime = time;
    }
    String firstImageUrl = html.querySelector('body > div.box > div.certen2 > div.gtps.fl > ul > li:nth-child(1) > a > img').attributes['src'];
    var thumbnailUrlTemplate = firstImageUrl.replaceAll("1.jpg", '');
    int lastIndex = thumbnailUrlTemplate.lastIndexOf("/");
    this.thumbnailUrlList.clear();
    this.originalImageUrlList.clear();

    //保存当前第一页的图片
    var lis = html.querySelectorAll('div.gtps.fl > ul > li');
    lis.forEach((element) {
      this.thumbnailUrlList.add(element.querySelector('img').attributes['src']);
    });

    var aArray = html.getElementsByClassName('page ps')[0].querySelectorAll('a');
    var totalPage = int.tryParse(
    aArray[aArray.length-3].text.trim());

    for (int i = 1; i <= totalPage; i++) {
      var response = await HttpManager.getInstance().get(url.replaceAll('.html', '') +'_'+ i.toString() + ".html", params);
      var html = HtmlParser.parseHTML(response);
      var lis = html.querySelectorAll('div.gtps.fl > ul > li');
      lis.forEach((element) {
        this.thumbnailUrlList.add(element.querySelector('img').attributes['src']);
      });
      }

    this.thumbnailUrlList.forEach((element) {
      int lastIndex = element.lastIndexOf("/");
      var originalImageUrl = element.replaceRange(lastIndex, lastIndex+2, "/");
      this.originalImageUrlList.add(originalImageUrl);
    });
    }catch(e){
    print('解析异常'+e);
    }

   return this;
  }
}