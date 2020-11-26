import 'package:aisi/common/base_view.dart';
import 'package:aisi/ui/widget/home_page_grid_widget.dart';
import 'package:aisi/ui/widget/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends BaseView {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('主页');
    final List tabs = ["新闻", "历史", "图片"];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('主页'),
          centerTitle: true,
          bottom: TabBar(
            tabs: tabs
                .map((e) => Tab(
                      text: e,
                    ))
                .toList(),
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: tabs
              .map((e) => Container(
                    alignment: Alignment.center,
                    child:
            HomePageGridWidget()
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
