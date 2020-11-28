import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/net/address.dart';
import 'package:aisi/res/colors.dart';
import 'package:aisi/ui/widget/list_model_widget.dart';
import 'package:aisi/ui/widget/list_pictures_set_widget.dart';
import 'package:aisi/ui/widget/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends BaseStatelessView {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('主页');
    final Map tabs = Map.from({
      "国产": Address.gaoqingmeinv,
      "日本": Address.ribenmeinv,
      "丝袜美腿": Address.siwameitui,
      "模特": Address.meimvmote,
      "最新": Address.zuixin,
      "社团": "",
    });
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colours.bk_gray,
        appBar: AppBar(
          title: Text('主页'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs.keys
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: tabs.values
              .map((e) => Container(
                    alignment: Alignment.center,
                    child: e == Address.meimvmote
                        ? ListModelWidget(e)
                        : ListPicturesSetWidget(e)
//                    Text(
//                      e,
//                      textScaleFactor: 5,
//                    )
                    ,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
