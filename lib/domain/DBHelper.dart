import 'package:loyverspos/model/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   static Database? _database;

//   factory DatabaseHelper() {
//     return _instance;
//   }

//   DatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'items.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//     CREATE TABLE items (
//       id INTEGER PRIMARY KEY AUTOINCREMENT,
//       name TEXT NOT NULL,
//       barcode TEXT NOT NULL,
//       price REAL NOT NULL
//     )
//     ''');
//   }

//   Future<List<ItemModel>> getItems() async {
//     Database db = await database;
//     var items = await db.query('items', orderBy: 'barcode');
//     List<ItemModel> itemList =
//         items.isNotEmpty ? items.map((c) => ItemModel.fromMap(c)).toList() : [];
//     return itemList;
//   }

//   Future<int> addItem(ItemModel item) async {
//     Database db = await database;
//     return await db.insert('items', item.toMap());
//   }

//   Future<int> updateItem(ItemModel item) async {
//     Database db = await database;
//     return await db
//         .update('items', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
//   }

//   Future<int> deleteItem(int id) async {
//     Database db = await database;
//     return await db.delete('items', where: 'id = ?', whereArgs: [id]);
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'items';

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<List<ItemModel>> getItems() async {
    QuerySnapshot snapshot =
        await _firestore.collection(_collection).orderBy('barcode').get();
    List<ItemModel> itemList = snapshot.docs
        .map((doc) =>
            ItemModel.fromMap(doc.data() as Map<String, dynamic>)..id = doc.id)
        .toList();
    return itemList;
  }

  Future<void> addItem(ItemModel item) async {
    DocumentReference docRef =
        await _firestore.collection(_collection).add(item.toMap());
    item.id = docRef.id; // Firestore generates a unique ID
  }

  Future<void> updateItem(ItemModel item) async {
    await _firestore.collection(_collection).doc(item.id).update(item.toMap());
  }

  Future<void> deleteItem(String id) async {
    await _firestore.collection(_collection).doc(id).delete();
  }
}

