import 'package:aisi/common/base_stateless_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drag_scale/core/drag_scale_widget.dart';

class LookImagesView extends BaseStatelessView {
  const LookImagesView(this.images, {this.position = 0, Key key})
      : super(key: key);
  final int position;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return
          Container(
            width: width,
            height: width,
            child: DragScaleContainer(
              doubleTapStillScale: true,
              child: CachedNetworkImage(
                  imageUrl: images[index],
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                        width: width,
                        height: height,
                        child: Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                      ),
                  errorWidget: (context, url, error) => Container(
                      width: width,
                      height: height,
                      child: Center(
                        child: Icon(Icons.error),
                      ))),
          )
          ,
        );
      },
    );
  }
}
