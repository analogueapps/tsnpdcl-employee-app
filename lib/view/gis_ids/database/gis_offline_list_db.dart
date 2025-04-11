import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_ids_model.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gis_database.db');
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
    CREATE TABLE gis_ids (
      gisId INTEGER PRIMARY KEY,
      regNum TEXT,
      regDate TEXT,
      feederCode TEXT,
      ssCode TEXT,
      workDescription TEXT,
      insertDate TEXT,
      ip TEXT,
      empId TEXT,
      deleteStatus TEXT,
      sectionCode TEXT,
      sapUploadFlag TEXT,
      sapUpRemarks TEXT,
      sapUpDate TEXT
    )
    ''');
  }

  // Insert a GisIdsModel into the database
  Future<void> insertGisId(GisIdsModel gisId) async {
    final db = await database;
    await db.insert(
      'gis_ids',
      gisId.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all GisIdsModel from the database
  Future<List<GisIdsModel>> getAllGisIds() async {
    final db = await database;
    final result = await db.query('gis_ids');
    return result.map((json) => GisIdsModel.fromJson(json)).toList();
  }

  // Retrieve a single GisIdsModel by gisId
  Future<GisIdsModel?> getGisIdById(int gisId) async {
    final db = await database;
    final result = await db.query(
      'gis_ids',
      where: 'gisId = ?',
      whereArgs: [gisId],
    );
    return result.isNotEmpty ? GisIdsModel.fromJson(result.first) : null;
  }

  // Delete a GisIdsModel by gisId
  Future<void> deleteGisId(int gisId) async {
    final db = await database;
    await db.delete(
      'gis_ids',
      where: 'gisId = ?',
      whereArgs: [gisId],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}