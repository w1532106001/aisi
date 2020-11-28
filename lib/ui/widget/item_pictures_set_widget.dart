import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/common/extension.dart';
import 'package:aisi/model/entity/pictures_set.dart';
import 'package:aisi/ui/view/model_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ItemPicturesSetWidget extends BaseStatelessView {
  const ItemPicturesSetWidget(this.picturesSet, this.isNeedMargin, {Key key})
      : super(key: key);
  final PicturesSet picturesSet;
  final bool isNeedMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.white,
      margin:
          isNeedMargin ? EdgeInsets.fromLTRB(10, 10, 5, 0) : EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 140,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: CachedNetworkImage(
                  imageUrl: picturesSet.cover,
                  fit: BoxFit.fitHeight,
                  // placeholder: (context, url) => Container(
                  //   width: double.infinity,
                  //   height: 140,
                  //   child: Center(child: CircularProgressIndicator()),
                  // ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                        width: double.infinity,
                        height: 140,
                        child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                      ),
                  errorWidget: (context, url, error) => Container(
                        width: double.infinity,
                        height: 140,
                        child: Center(child: Icon(Icons.error)),
                      )),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: getPicturesSetDetailWidgetList(context),
              ).padding(EdgeInsets.only(left: 10)),
            ),
          )
        ],
      ).padding(EdgeInsets.only(top: 10, bottom: 10)),
    );
  }

  // ignore: missing_return
  List<Widget> getPicturesSetDetailWidgetList(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(Container(
      child: Text(
        picturesSet.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      alignment: Alignment.centerLeft,
    ));
    if(picturesSet.quantity!=null&&picturesSet.fileSize!=null){
      widgetList.add(Container(
        child: Text(
          '数量:' +
              picturesSet.quantity.toString() +
              '  文件大小: ' +
              picturesSet.fileSize,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        alignment: Alignment.centerLeft,
      ));
    }

    widgetList.add(Container(
      child: Text(
        '点击数: ' +
            picturesSet.clickNum.toString() +
            '  下载数: ' +
            picturesSet.downNum.toString(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      alignment: Alignment.centerLeft,
    ));
    if (picturesSet.associationName != null) {
      widgetList.add(Container(
        child: RichText(
          text: TextSpan(
              text: '隶属于:  ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: picturesSet.associationName,
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showMessage('点击了 社团名称: ' + picturesSet.associationName);
                      })
              ]),
        ),
        alignment: Alignment.centerLeft,
      ));
    }
    if (picturesSet.modelName != null) {
      widgetList.add(Container(
        child: RichText(
          text: TextSpan(
              text: '模特:  ',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                    text: picturesSet.modelName,
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) {
                            //指定跳转的页面
                            return ModelView(picturesSet.modelUrl);
                          },
                        ));
                      })
              ]),
        ),
        alignment: Alignment.centerLeft,
      ));
    }
    widgetList.add(Container(
      child: Text(
        '更新时间:' + picturesSet.updateTime,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black),
      ),
      alignment: Alignment.centerLeft,
    ));
    return widgetList;
  }
}
