import 'package:aisi/common/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aisi/common/extension.dart';

class ItemPicturesSetWidget extends BaseView {
  const ItemPicturesSetWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 5, 0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://dss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1819216937,2118754409&fm=26&gp=0.jpg"),
            ).padding(EdgeInsets.all(5)),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text('123'),
            ),
          )
        ],
      ),
    );
  }
}
