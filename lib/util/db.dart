import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/restaurants.dart';

class DatabaseHelper {
  static late Database _database;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'note_db.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
               name TEXT, 
               description TEXT,
               pictureId TEXT,
               city TEXT,
               rating NUMBER
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertRestaurant(Restaurants restaurant) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.toMap());
  }

  Future<List<Restaurants>> getRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => Restaurants.fromMap(res)).toList();
  }

  Future<void> deleteRestaurant(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}