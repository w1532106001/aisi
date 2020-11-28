import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/common/base_widget.dart';
import 'package:aisi/model/entity/model.dart';
import 'package:aisi/model/entity/pictures_set.dart';
import 'package:aisi/net/address.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:aisi/ui/view/model_view.dart';
import 'package:aisi/ui/widget/item_pictures_set_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aisi/common/extension.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'item_model_widget.dart';
class ListModelWidget extends StatefulWidget   {
  ListModelWidget(this.url);
  final String url;
  @override
  _ListModelWidgetState createState() => _ListModelWidgetState();
}

class _ListModelWidgetState extends State<ListModelWidget> with AutomaticKeepAliveClientMixin,BaseWidget{
  @override
  bool get wantKeepAlive => true;
  List<Model> modelList = [];
  EasyRefreshController _easyRefreshController;
  var currentPage = 1;

  @override
  void initState() {
    super.initState();
    _easyRefreshController = EasyRefreshController();
  }
  @override
  Widget build(BuildContext context) {
    var params = DataHelper.getBaseMap();
    return EasyRefresh(
      controller: _easyRefreshController,
      firstRefresh: true,
      firstRefreshWidget: showLoading(),
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      child: GridView.builder(
          padding: EdgeInsets.only(left: 10,right: 10),
          itemCount: modelList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: 0.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: 0.70),
          itemBuilder:  (BuildContext context, int index) {
            //Widget Function(BuildContext context, int index)
            return GestureDetector(
              child: ItemModelWidget(modelList[index]),
              onTap: ()=>{
                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (context) {
                    //指定跳转的页面
                    return ModelView(modelList[index].url);
                  },
                ))
              },
            );
          }),
      onRefresh: () async {
        await HttpManager.getInstance(baseUrl: "")
            .get(super.widget.url + currentPage.toString() + ".html", params)
            .then((event) {
          var list = Model.htmlToModelList(event);
          setState(() {
            currentPage = 1;
            modelList = list;
          });
          _easyRefreshController.resetLoadState();
          _easyRefreshController.finishRefresh(success: true);
        });
      },
      onLoad: () async {
        await HttpManager.getInstance()
            .get(super.widget.url + (currentPage + 1).toString() + ".html",
            params)
            .then((event) {
          var list = Model.htmlToModelList(event);
          setState(() {
            currentPage++;
            modelList.addAll(list);
          });
          _easyRefreshController.finishLoad();
        });
      },
    );
  }
}
