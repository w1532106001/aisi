import 'dart:io';
import 'dart:math';

import 'package:aisi/common/base_stateless_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LookLocalImagesView extends BaseStatelessView {
  const LookLocalImagesView({Key key})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var d = Directory('/storage/emulated/0/Android/data/com.example.aisi/files/ROSI写真 2020.11.24 NO.3277');
    var fileList = d.listSync();
    List<Widget> imageList = [];
    fileList.forEach((element) {
      Image image = Image.file(element);
      imageList.add(image);
    });
    return ListView(
      children: imageList,
    );
  }
}
