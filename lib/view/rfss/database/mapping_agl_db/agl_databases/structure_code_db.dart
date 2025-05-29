import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/rfss/model/dtrStructureEntity.dart';

class StructureDatabaseHelper {
  static final StructureDatabaseHelper instance = StructureDatabaseHelper._init();
  static Database? _database;

  StructureDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('apl_structure_codes.db');
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
    CREATE TABLE dtr_structures (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      structureCode TEXT NOT NULL UNIQUE,
      distributionCode TEXT,
      distributionName TEXT,
      feederName TEXT,
      feederCode TEXT,
      capacity TEXT,
      landMark TEXT,
      lat TEXT,
      lon TEXT,
      sectionCode TEXT,
      createdBy TEXT,
      createdDate TEXT,
      searchString TEXT,
      ssNo TEXT,
      ssCode TEXT,
      structureType TEXT,
      plinthType TEXT,
      abSwitch TEXT,
      hgFuseSet TEXT,
      ltFuseSet TEXT,
      ltFuseType TEXT,
      loadPattern TEXT,
      failureCount INTEGER
    )
  ''');
  }


  Future<void> insertStructure(DTRStructureEntity structure) async {
    final db = await database;
    await db.insert(
      'dtr_structures',
      structure.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<DTRStructureEntity>> getAllStructures() async {
    final db = await database;
    final result = await db.query('dtr_structures');
    return result.map((e) => DTRStructureEntity.fromJson(e)).toList();
  }

  Future<List<String>> getAllStructureCodes() async {
    final structures = await getAllStructures();
    return structures
        .map((e) => e.structureCode)
        .whereType<String>() // This filters out any nulls safely
        .toList();
  }

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('dtr_structures');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}