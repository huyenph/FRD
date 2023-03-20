import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:hpcompose/domain/models/user_model.dart';

class DatabaseHelper {
  static const databaseName = 'app_database.db';
  static const databaseVersion = 1;
  static const tableName = 'user';

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, name TEXT NOT NULL)',
    );
  }

  Future<void> insert(UserModel user) async {
    Database db = await instance.database;
    await db.insert(
      tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['id'];
    return await db.update(tableName, row, where: 'id = ?', whereArgs: [id]);
  }
}
