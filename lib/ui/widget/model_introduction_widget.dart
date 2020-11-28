import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/model/entity/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aisi/common/extension.dart';

class ModelIntroductionWidget extends BaseStatelessView{
  const ModelIntroductionWidget(this.model,{Key key}) : super(key: key);
  final Model model;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 140,
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: CachedNetworkImage(
                  imageUrl: model.cover,
                  fit: BoxFit.fitHeight,
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
                children: [
                  Container(
                    child: Text(
                      model.name,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    child: Text(
                      model.introduction,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    child: Text(
                      '点击数: ' +
                          model.clickNum.toString() +
                          '  下载数: ' +
                          model.downNum.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    alignment: Alignment.centerLeft,
                  )
                ],
              ).padding(EdgeInsets.only(left: 10)),
            ),
          )
        ],
      ).padding(EdgeInsets.only(top: 10, bottom: 10)),
    );
  }
}