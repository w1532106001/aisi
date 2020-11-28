import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../res/dimens.dart';
import 'mvp_view.dart';

class BaseWidget implements MvpView  {
  @override
  hideProgressDialog() {
    BotToast.closeAllLoading();
  }

  @override
  Widget showError(bool isReload) {
    return showErrorWithMessage("网络异常", isReload);
  }

  @override
  Widget showErrorWithMessage(String message, bool isReload) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
          ),
          Text(
            isReload ? "点击重新加载" : "",
            style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
          )
        ],
      ),
    );
  }

  @override
  Widget showLoading() {
    return showLoadingWithMessage("正在加载中");
  }

  @override
  Widget showLoadingWithMessage(String message) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
                padding: EdgeInsets.only(top: Dimens.gap_dp12),
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: Dimens.font_sp18),
                ))
          ],
        ));
  }

  @override
  showMessage(String message) {
    BotToast.showText(text: message);
  }

  @override
  showProgressDialog(String message) {
    BotToast.showLoading(
      duration: null,
      clickClose: false,
      allowClick: false,
    );
  }
}
