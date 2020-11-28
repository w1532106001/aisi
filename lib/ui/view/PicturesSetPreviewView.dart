import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/common/down_manager.dart';
import 'package:aisi/model/entity/pictures_set.dart';
import 'package:aisi/res/colors.dart';
import 'package:aisi/ui/view/look_images_view.dart';
import 'package:aisi/ui/widget/item_pictures_set_widget.dart';
import 'package:aisi/utils/permiss_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PicturesSetPreviewView extends BaseStatelessView {
  const PicturesSetPreviewView(this.picturesSet, {Key key}) : super(key: key);
  final PicturesSet picturesSet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colours.bk_gray,
      body: Center(
        child: FutureBuilder(
          future: picturesSet.parsePicturesSet(picturesSet.url),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                var data = snapshot.data;
                // 请求成功，显示数据
                return Container(
                  child: ListView(
                    children: [
                      ItemPicturesSetWidget(picturesSet, false),
                      Container(
                        child: GestureDetector(
                          onTap: () => {
                          PermissUtils.requestPermiss(context)
                              .then((value) => {
                          if (value){
                          DownManager.download(picturesSet,context)
                          // print('下载当前图集：' + picturesSet.name)
                          }
                          })
                        },
                          child: Icon(Icons.file_download),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.thumbnailUrlList.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 3,
                                //纵轴间距
                                mainAxisSpacing: 0.0,
                                //横轴间距
                                crossAxisSpacing: 10.0,
                                //子组件宽高长度比例
                                childAspectRatio: 0.75),
                            itemBuilder: (BuildContext context, int index) {
                              //Widget Function(BuildContext context, int index)
                              return GestureDetector(
                                child: Center(
                                  child: CachedNetworkImage(
                                      imageUrl:
                                      picturesSet.thumbnailUrlList[index],
                                      fit: BoxFit.fitHeight,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error)),
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .push(new MaterialPageRoute(
                                    builder: (context) {
                                      //指定跳转的页面
                                      return LookImagesView(
                                        picturesSet.originalImageUrlList,
                                        position: index,
                                      );
                                    },
                                  ));
                                },
                              );
                            }),
                      )
                    ],
                  ),
                );
              }
            } else {
              // 请求未结束，显示loading
              return showLoading();
            }
          },
        ),
      ),
    );
  }
}
