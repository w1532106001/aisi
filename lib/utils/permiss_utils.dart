

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissUtils{
  static Future<bool> requestPermiss(BuildContext context) async {
    var b = false;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    if (await Permission.storage.request().isGranted) {
      b = true;
      // Either the permission was already granted before or the user just granted it.
    }
    if (await Permission.storage.isPermanentlyDenied) {
       showDialog(context: context,builder: (ctx){
         return AlertDialog(
           title: Text("提示"),
           content: Text("下载功能需要存储权限"),
           actions: <Widget>[
             FlatButton(
               child: Text("取消"),
               onPressed: () => Navigator.of(context).pop(), //关闭对话框
             ),
             FlatButton(
               child: Text("确认"),
               onPressed: () {
                 // ... 执行删除操作
                 Navigator.of(context).pop(true); //关闭对话框
                 openAppSettings();
               },
             ),
           ],
         );
       });
    }
    return b;
  }
}