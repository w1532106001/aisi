import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DBManger {
  static const int _VERSION = 1;
  static const String _DB_NAME = "pictures_set.common.db";
  static Database _dataBase;

  static init() async {
    var dataBasePath = await getDatabasesPath();
    String dbName = _DB_NAME;
    String path = dataBasePath + dbName;
    if(Platform.isIOS){
      path = dataBasePath + "/" +dbName;
    }

    _dataBase = await openDatabase(path ,version: _VERSION,onCreate: (Database db,int version)async{
//创建表
    });
  }

  static Future<Database> getCurrentDatabase() async{
    if(_dataBase == null){
      await init();
    }
    return _dataBase;
  }

  static close(){
    _dataBase?.close();
    _dataBase = null;
  }
}
