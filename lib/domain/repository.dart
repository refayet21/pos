import 'package:loyverspos/domain/DBHelper.dart';
import 'package:loyverspos/domain/Util.dart';
import 'package:loyverspos/model/item_model.dart';

class ItemRepository {
  DBHelper dbHelper = DBHelper();

  Future<List<ItemModel>> getStudent() async {
    var dbClient = await dbHelper.db;

    List<Map<String, dynamic>> maps =
        await dbClient.query(tableName, columns: ['id', 'name']);
    List<ItemModel> item = [];
    for (int i = 0; i < maps.length; i++) {
      item.add(ItemModel.fromMap(maps[i]));
    }
    return item;
  }

  // Future<List<ItemModel>> getStudent() async {
  //   var dbClient = await dbHelper.db;

  //   List<Map<String, dynamic>> maps =
  //       await dbClient.query(tableName, columns: ['id', 'name']);
  //   List<ItemModel> items = maps.map((map) => ItemModel.fromMap(map)).toList();

  //   return items;
  // }

  Future<int> add(ItemModel studentModel) async {
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, studentModel.toMap());
  }

  Future<int> update(ItemModel studentModel) async {
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableName, studentModel.toMap(),
        where: 'id = ?', whereArgs: [studentModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
