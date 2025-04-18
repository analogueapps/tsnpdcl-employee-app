import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      CREATE TABLE structure_codes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        structureCode TEXT NOT NULL UNIQUE
      )
    ''');
  }

  Future<void> insertStructureCode(String structureCode) async {
    final db = await database;
    await db.insert(
      'structure_codes',
      {'structureCode': structureCode},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<String>> getAllStructureCodes() async {
    final db = await database;
    final result = await db.query('structure_codes');
    return result.map((e) => e['structureCode'] as String).toList();
  }

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('structure_codes');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}