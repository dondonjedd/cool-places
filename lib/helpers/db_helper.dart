import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
        path.join(
          dbPath,
          'places.db',
        ),
        version: 1, onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE user_places (id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final sqlDB = await DBHelper.database();
    await sqlDB.insert(table, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    print('getting data');
    final sqlDB = await DBHelper.database();
    print('data fetched ');
    return sqlDB.query(table);
  }
}
