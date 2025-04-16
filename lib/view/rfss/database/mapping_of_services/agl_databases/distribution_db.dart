import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:tsnpdcl_employee/view/dtr_master/model/circle_model.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('distribution.db');
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
    const String createSubstationTable = '''
    CREATE TABLE substations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      optionCode TEXT NOT NULL UNIQUE,
      optionName TEXT NOT NULL
    )
    ''';

    await db.execute(createSubstationTable);
  }

  Future<void> insertSubstations(List<SubstationModel> substations) async {
    final db = await database;
    Batch batch = db.batch();

    for (var substation in substations) {
      batch.insert(
        'substations',
        {
          'optionCode': substation.optionCode,
          'optionName': substation.optionName,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<SubstationModel>> getSubstations() async {
    final db = await database;
    final maps = await db.query('substations');

    return List.generate(maps.length, (i) {
      return SubstationModel(
        optionCode: maps[i]['optionCode'] as String,
        optionName: maps[i]['optionName'] as String,
      );
    });
  }

  Future<void> clearSubstations() async {
    final db = await database;
    await db.delete('substations');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}