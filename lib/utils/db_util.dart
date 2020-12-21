import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT,lat REAL, long REAL, address TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}
