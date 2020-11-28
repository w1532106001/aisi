import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/model/entity/model.dart';
import 'package:aisi/model/entity/pictures_set.dart';
import 'package:aisi/res/dimens.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aisi/common/extension.dart';

class ItemModelWidget extends BaseStatelessView {
  const ItemModelWidget(this.model, {Key key}) : super(key: key);
  final Model model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))), //设置圆角
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                width: double.infinity,
                height: 180,
                imageUrl: model.cover,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text(model.name)],
          ).padding(EdgeInsets.only(
            left: 5,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '热度：' + model.clickNum + ' 下载：' + model.downNum,
                style: TextStyle(fontSize: Dimens.font_sp12),
              )
            ],
          ).padding(EdgeInsets.only(
            left: 5,
          ))
        ],
      ),
    ).padding(EdgeInsets.only(top: 10));
  }
}
