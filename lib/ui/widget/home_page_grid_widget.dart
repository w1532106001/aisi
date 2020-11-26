import 'package:aisi/common/base_view.dart';
import 'package:aisi/net/address.dart';
import 'package:aisi/net/data_helper.dart';
import 'package:aisi/net/http_manager.dart';
import 'package:flutter/cupertino.dart';

class HomePageGridWidget extends BaseView{
  const HomePageGridWidget({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var params = DataHelper.getBaseMap();
    return Center(
      child: FutureBuilder(
        future: HttpManager.getInstance().get("https://www.baidu.com",params),
        builder:  (BuildContext context, AsyncSnapshot snapshot) {
          // 请求已结束
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              // 请求失败，显示错误
              return Text("Error: ${snapshot.error}");
            } else {
              // 请求成功，显示数据
              return Text("Contents: ${snapshot.data}");
            }
          } else {
            // 请求未结束，显示loading
            return showLoading();
          }
        },
      ),
    );

  }
}