import 'package:aisi/common/base_view.dart';
import 'package:aisi/ui/widget/main_drawer.dart';
import 'package:flutter/material.dart';

class DownLoadView extends BaseView{
  const DownLoadView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('下载');
    return Scaffold(
      appBar: AppBar(
        title: Text("下载"),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: Text('下载页面'),
      ),
    );
  }
}