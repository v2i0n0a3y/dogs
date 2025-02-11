import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tot/Api/model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('dogs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE dogs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        breed TEXT,
        origin TEXT,
        imageUrl TEXT
      )
    ''');
  }
  //
  // Future<int> insertDog(DogModel dog) async {
  //   final db = await instance.database;
  //   return await db.insert('dogs', dog.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  Future<List<DogModel>> getDogs() async {
    final db = await instance.database;
    final result = await db.query('dogs');
    return result.map((json) => DogModel.fromJson(json)).toList();
  }

  Future<int> deleteDog(int id) async {
    final db = await instance.database;
    return await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }
}
