import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_mapped_model.dart';

class AGLUnMappedDatabaseHelper {
  static final AGLUnMappedDatabaseHelper _instance = AGLUnMappedDatabaseHelper._internal();
  static Database? _database;

  factory AGLUnMappedDatabaseHelper() => _instance;

  AGLUnMappedDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'unmapped_services.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE unmapped_services(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eroCode TEXT,
        sectionCode TEXT,
        eroSecCode TEXT,
        areaCode TEXT,
        uscno TEXT UNIQUE,
        scno TEXT,
        name TEXT,
        cat TEXT
      )
    ''');
  }

  // Insert or replace services
  Future<void> insertUnMappedServices(List<UploadMappedService> services) async {
    final db = await database;
    final batch = db.batch();

    for (final service in services) {
      batch.insert(
        'unmapped_services',
        service.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  // Get all services
  Future<List<UploadMappedService>> getUnMappedServices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('unmapped_services');
    return List.generate(maps.length, (i) {
      return UploadMappedService.fromJson(maps[i]);
    });
  }

  // Clear all services
  Future<void> clearUnMappedServices() async {
    final db = await database;
    await db.delete('unmapped_services');
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}