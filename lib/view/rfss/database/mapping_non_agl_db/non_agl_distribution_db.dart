import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';

class NonAglDistributionDb {
  static final NonAglDistributionDb instance = NonAglDistributionDb._init();
  static Database? _database;

  // Column names as constants for type safety
  static const String tableName = 'non_agl_distribution';
  static const String columnId = 'id';
  static const String columnOptionCode = 'optionCode';
  static const String columnOptionName = 'optionName';

  NonAglDistributionDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('non_agl_distribution.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnOptionCode TEXT NOT NULL UNIQUE,
        $columnOptionName TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertNonAglDistribution(List<SubstationModel> items) async {
    final db = await database;
    final batch = db.batch();

    for (var item in items) {
      batch.insert(
        tableName,
        {
          columnOptionCode: item.optionCode,
          columnOptionName: item.optionName,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<SubstationModel>> getAllNonAglDistribution() async {
    final db = await database;
    final maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return SubstationModel(
        optionCode: maps[i][columnOptionCode] as String,
        optionName: maps[i][columnOptionName] as String,
      );
    });
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(tableName);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}