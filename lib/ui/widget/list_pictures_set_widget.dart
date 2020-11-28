import 'package:aisi/common/base_widget.dart';
import 'package:aisi/model/entity/pictures_set.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:aisi/ui/view/PicturesSetPreviewView.dart';
import 'package:aisi/ui/widget/item_pictures_set_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ListPicturesSetWidget extends StatefulWidget {
  ListPicturesSetWidget(this.url, {Key key});

  final String url;

  @override
  _ListPicturesSetWidgetState createState() => _ListPicturesSetWidgetState();
}

class _ListPicturesSetWidgetState extends State<ListPicturesSetWidget>
    with AutomaticKeepAliveClientMixin, BaseWidget {
  @override
  bool get wantKeepAlive => true;

  List<PicturesSet> picturesSetList = [];
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
      child: ListView.builder(
        itemCount: picturesSetList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ItemPicturesSetWidget(picturesSetList[index], true),
            onTap: () => {
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) {
                  //指定跳转的页面
                  return PicturesSetPreviewView(picturesSetList[index]);
                },
              ))
            },
          );
        },
      ),
      onRefresh: () async {
        await HttpManager.getInstance(baseUrl: "")
            .get(super.widget.url + currentPage.toString() + ".html", params)
            .then((event) {
          var list = PicturesSet.htmlToPicturesSetList(event);
          setState(() {
            currentPage = 1;
            picturesSetList = list;
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
          var list = PicturesSet.htmlToPicturesSetList(event);
          setState(() {
            currentPage++;
            picturesSetList.addAll(list);
          });
          _easyRefreshController.finishLoad();
        });
      },
    );
  }
}
