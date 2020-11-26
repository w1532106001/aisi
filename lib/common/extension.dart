import 'package:flutter/material.dart';

extension StringExt on String {
  double toDouble() {
    return double.parse(this);
  }

  int toInt() {
    return int.parse(this);
  }

  bool isMobile() {
    return RegExp(
            r'^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8])|(19)[0-9])\d{8}$')
        .hasMatch(this);
  }
}

extension WidgetExt on Widget {
  Widget padding(EdgeInsetsGeometry padding) {
    return Padding(
      child: this,
      padding: padding,
    );
  }

  Material gesture(gestureTapCallback, {
    GestureTapCallback onTap,
    GestureTapCallback onDoubleTap,
    GestureLongPressCallback onLongPress,
  }) {
    return Material(
      child: InkWell(
        child: this,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
