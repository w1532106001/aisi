import 'package:aisi/common/db/pictures_set_provider.dart';
import 'package:aisi/model/entity/pictures_set.dart';
import 'package:flutter/cupertino.dart';

class PicturesSetViewProviderModel extends ChangeNotifier{

  List<PicturesSet> picturesSetList = [];
  var picturesSetProvider = PicturesSetProvider();
  PicturesSetViewProviderModel() {
   Future.sync(() => init());
  }

  updatePicturesSetList() async{
    picturesSetList = await picturesSetProvider.getAllPicturesSet();
    notifyListeners();
  }

  init() async{
    await picturesSetProvider.open();
    picturesSetList = await picturesSetProvider.getAllPicturesSet();
  }

  bool isDown(String url){
    var b = false;
    picturesSetList.forEach((element) {
      if (element.url == url) {
        b = true;
      }
    });
    return b;
  }
}