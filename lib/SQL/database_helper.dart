import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

// PREPARING
class DBhelper {
  static Future<Database> createDb() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      version: 1,
      path.join(dbPath, 'transactions.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_transactions(id TEXT PRIMARY KEY, transactionDate TEXT, transactionAmount , recipent TEXT)');
      },
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
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
}
