import 'package:aisi/model/provider/main_drawer_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainDrawerModel>(context);
    return Drawer(
        child: ListView(
      children: [
        Container(
          height: 56,
          color: Colors.blue,
        ),
        Column(
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              selected: 0 == provider.selectIndex,
              leading: Icon(Icons.home),
              title: Text('主页'),
              onTap: () => {provider.updateSelectIndex(0, context)},
            ),
            ListTile(
              selected: 1 == provider.selectIndex,
              leading: Icon(Icons.file_download),
              title: Text('下载'),
              onTap: () => {provider.updateSelectIndex(1, context)},
            ),
          ]).toList(),
        )
      ],
    ));
  }
}
