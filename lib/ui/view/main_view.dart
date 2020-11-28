import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/model/provider/main_drawer_model.dart';
import 'package:aisi/res/colors.dart';
import 'package:aisi/ui/view/download_View.dart';
import 'package:aisi/ui/view/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends BaseStatelessView {
  const MainView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //直接创建主页与下载页，避免provider重建页面时刷新这两个页面
    final page = [HomeView(),DownLoadView()];
    return ChangeNotifierProvider(
      create: (_) => MainDrawerModel(),
      child: Scaffold(
        backgroundColor: Colours.bk_gray,
          body: Consumer<MainDrawerModel>(
              builder: (_, mainDrawerModel, __) =>
                  IndexedStack(
                    index: mainDrawerModel.selectIndex,
                    children: page,
                  ))),
    );
  }
}
