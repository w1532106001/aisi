import 'package:aisi/common/base_widget.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../res/dimens.dart';
import 'mvp_view.dart';


class BaseStatelessView extends StatelessWidget with BaseWidget{
  const BaseStatelessView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
