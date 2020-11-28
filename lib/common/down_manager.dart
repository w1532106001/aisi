import 'dart:io';

import 'package:aisi/model/entity/pictures_set.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class DownManager{
  static download(PicturesSet picturesSet,BuildContext context) async{
    //1.保存picturesSet到数据库
    String path = await _findLocalPath(context);
    var filePath = Directory(path+"/"+picturesSet.name);
    try {
      bool exists = await filePath.exists();
      if (!exists) {
        await filePath.create();
      }
    } catch (e) {
      print(e);
    }
    for(int i = 1;i<=picturesSet.originalImageUrlList.length;i++){
      var newFilePath = filePath.path+"/"+i.toString()
          +".jpg";
      print('$newFilePath');
      var fileInfo = await DefaultCacheManager().getFileFromCache(picturesSet.originalImageUrlList[i-1]);
      if(fileInfo!=null){
        await fileInfo.file.copy(newFilePath);
      }else{
        fileInfo = await DefaultCacheManager().downloadFile(picturesSet.originalImageUrlList[i-1]);
        await fileInfo.file.copy(newFilePath);
      }
      print('${picturesSet.originalImageUrlList[i-1]}--$i/${picturesSet.originalImageUrlList.length}');
    }
    print('下载完成');

  }

  // 获取存储路径
  static Future<String> _findLocalPath(BuildContext context) async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    return directory.path;
  }

}