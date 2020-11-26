import 'package:flutter_html/html_parser.dart';

class PicturesSet{
  String cover;
  String name;
  int quantity = 30;
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
            var a = element.querySelector('a');
            var associationName = a.text;
            var associationUrl = a.attributes['href'];
            picturesSet.associationName = associationName.trim();
            picturesSet.associationUrl = associationUrl.trim();
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
   PicturesSet parsePicturesSetUrl(String data){
    try{
      var html = HtmlParser.parseHTML(data);
      var hd3 = html.getElementsByClassName('hd3')[0];
      var gr = hd3.getElementsByClassName('gr')[0];
      if(gr.text.indexOf('的所有')!=-1){
        this.modelName = gr.text.substring(0,gr.text.indexOf('的所有')-3);
        this.modelUrl = gr.attributes['href'];
      }

      var time = hd3.text.substring(hd3.text.indexOf('发布时间：')+5).trim();
      if(time.isNotEmpty){
        this.updateTime = time;
      }
      String firstImageUrl = html.querySelector('body > div.box > div.certen2 > div.gtps.fl > ul > li:nth-child(1) > a > img').attributes['src'];
      var thumbnailUrlTemplate = firstImageUrl.replaceAll("1.jpg", '');
      var originalImageUrlTemplate = thumbnailUrlTemplate.replaceAll("m24mnorg", '24mnorg');
      this.thumbnailUrlList.clear();
      this.originalImageUrlList.clear();
      for (int i = 1; i <= quantity; i++) {
        this.thumbnailUrlList.add(thumbnailUrlTemplate+i.toString()+".jpg");
        this.originalImageUrlList.add(originalImageUrlTemplate+i.toString()+".jpg");
        print(originalImageUrlTemplate+i.toString()+".jpg");
      }
    }catch(e){
      print('解析异常');
    }
    return this;
  }

}