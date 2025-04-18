import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NonAglStructureDb {
  static final NonAglStructureDb instance = NonAglStructureDb._init();
  static Database? _database;

  NonAglStructureDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('non_agl_structure.db');
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
      CREATE TABLE non_agl_structure (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        structureCode TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future<void> insertStructureCode(String structureCode) async {
    final db = await database;
    await db.insert(
      'non_agl_structure',
      {'structureCode': structureCode},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<String>> getAllStructureCodes() async {
    final db = await database;
    final result = await db.query('non_agl_structure');
    return result.map((e) => e['structureCode'] as String).toList();
  }

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('non_agl_structure');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }

}