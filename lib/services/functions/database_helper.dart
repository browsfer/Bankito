import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

// PREPARING
class DBhelper {
  static Future<Database> createDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(version: 1, path.join(dbPath, 'user_cards.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE user_cards(id TEXT PRIMARY KEY, name TEXT, currency TEXT, cardNumber INTEGER, expiryDate TEXT, cardType TEXT)');
    });
  }

  static Future<void> insertData(
      String table, Map<String, dynamic> data) async {
    final database = await DBhelper.createDb();
    await database.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final database = await DBhelper.createDb();
    return database.query(table);
  }

  static Future<void> deleteUserCard(String id) async {
    final database = await DBhelper.createDb();
    await database.delete(
      'user_cards',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
