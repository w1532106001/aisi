import 'package:aisi/common/base_widget.dart';
import 'package:aisi/model/entity/model.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:aisi/ui/view/PicturesSetPreviewView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'model_introduction_widget.dart';

class ModelListPicturesSetWidget extends StatefulWidget {
  ModelListPicturesSetWidget(this.model, this.url, {Key key});

  final Model model;
  final String url;

  @override
  _ModelListPicturesSetWidgetState createState() =>
      _ModelListPicturesSetWidgetState();
}

class _ModelListPicturesSetWidgetState extends State<ModelListPicturesSetWidget>
    with BaseWidget {
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
      firstRefresh: false,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      child: ListView(
        children: [
          ModelIntroductionWidget(super.widget.model),
          GridView.builder(
            shrinkWrap: true,
            //为true可以解决子控件必须设置高度的问题
            physics: NeverScrollableScrollPhysics(),
            //禁用滑动事件
            itemCount: super.widget.model.picturesSetList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 2,
                //纵轴间距
                mainAxisSpacing: 0.0,
                //横轴间距
                crossAxisSpacing: 10.0,
                //子组件宽高长度比例
                childAspectRatio: 0.66),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  color: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  //设置圆角
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            height: 180,
                            imageUrl:
                                super.widget.model.picturesSetList[index].cover,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Container(
                              width: double.infinity,
                              height: 180,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: double.infinity,
                              height: 180,
                              child: Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5),
                        child: Text(super.widget.model.picturesSetList[index].name,maxLines: 2,
                          overflow: TextOverflow.ellipsis,),
                      )
                      ,
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        child: Text('热度：' +
                            super
                                .widget
                                .model
                                .picturesSetList[index]
                                .clickNum
                                .toString()),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        child: Text('下载：' +
                            super
                                .widget
                                .model
                                .picturesSetList[index]
                                .downNum
                                .toString()),
                      ),
                    ],
                  ),
                ),
                onTap: () => {
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) {
                      //指定跳转的页面
                      return PicturesSetPreviewView(
                          super.widget.model.picturesSetList[index]);
                    },
                  ))
                },
              );
            },
          ),
        ],
      ),
      onLoad: () async {
        if (super.widget.model.page == currentPage) {
          _easyRefreshController.finishLoad(noMore: true);
        } else {
          await HttpManager.getInstance()
              .get(
                  super.widget.url +
                      '_' +
                      (currentPage + 1).toString() +
                      ".html",
                  params)
              .then((event) {
            var list = Model.parsePicturesSetList(event);
            setState(() {
              currentPage++;
              super.widget.model.picturesSetList.addAll(list);
            });
            _easyRefreshController.finishLoad(
                noMore: super.widget.model.page == currentPage);
          });
        }
      },
    );
  }
}
