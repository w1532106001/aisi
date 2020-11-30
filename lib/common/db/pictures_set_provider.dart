import 'package:aisi/model/entity/pictures_set.dart';
import 'package:sqflite/sqflite.dart';

class PicturesSetProvider {
  Database db;
  final String tableName = 'pictures_set';
  final String columnId = 'url';

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table pictures_set ( 
  url text primary key , 
  cover text,
  name text,
  quantity integer,
  fileSize text,
  updateTime text,
  clickNum integer,
  downNum integer,
  associationName text,
  associationUrl text,
  modelName text,
  modelUrl text,
  thumbnailUrlList text,
  originalImageUrlList text,
  downProgress integer,
  downTotal integer,
  downType integer)
''');
    });
  }

  Future<PicturesSet> insert(PicturesSet picturesSet) async {
    await db.insert(tableName, PicturesSet.toMap(picturesSet));
    return null;
  }

  Future<PicturesSet> getPicturesSet(String url) async {
    List<Map> maps = await db.query(tableName,
        columns: [
          "url",
          "cover",
          "name",
          "quantity",
          "fileSize",
          "updateTime",
          "clickNum",
          "downNum",
          "associationName",
          "associationUrl",
          "modelName",
          "modelUrl",
          "thumbnailUrlList",
          "originalImageUrlList",
          "downProgress",
          "downTotal",
          "downType"
        ],
        where: 'url = ?',
        whereArgs: [url]);
    if (maps.length > 0) {
      return PicturesSet.fromMap(maps.first);
    }
    return null;
  }

  Future<int> delete(String url) async {
    return await db.delete(tableName, where: 'url = ?', whereArgs: [url]);
  }

  Future<int> update(PicturesSet picturesSet) async {
    return await db.update(tableName, PicturesSet.toMap(picturesSet),
        where: 'url = ?', whereArgs: [picturesSet.url]);
  }

  Future close() async => db.close();
}
