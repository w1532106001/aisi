import 'package:flutter/cupertino.dart';

class MainDrawerModel extends ChangeNotifier {
  var selectIndex = 0;
  MainDrawerModel();
  updateSelectIndex(int index,BuildContext context){
    // ignore: unnecessary_statements
    selectIndex = index;
    notifyListeners();
    Navigator.pop(context);
  }
}