import 'package:aisi/common/base_stateless_view.dart';
import 'package:aisi/model/entity/model.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:aisi/res/colors.dart';
import 'package:aisi/ui/widget/model_introduction_widget.dart';
import 'package:aisi/ui/widget/model_list_pictures_set_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelView extends BaseStatelessView {
  const ModelView(this.url, {Key key}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    var params = DataHelper.getBaseMap();
    ScrollController _scrollController = new ScrollController();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colours.bk_gray,
      body: Center(
        child: FutureBuilder(
          future: HttpManager.getInstance().get(url, params),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                var data = Model.htmlToModel(snapshot.data);
                // 请求成功，显示数据
                return ModelListPicturesSetWidget(data,
                    url);
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
