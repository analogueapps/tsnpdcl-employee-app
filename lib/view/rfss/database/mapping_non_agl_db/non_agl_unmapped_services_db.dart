import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_mapped_model.dart';

class NonAglUnmappedServicesDb {
  static final NonAglUnmappedServicesDb _instance = NonAglUnmappedServicesDb._internal();
  static Database? _database;

  // Table and column constants
  static const String tableName = 'non_agl_unmapped';
  static const String columnId = 'id';
  static const String columnEroCode = 'eroCode';
  static const String columnSectionCode = 'sectionCode';
  static const String columnEroSecCode = 'eroSecCode';
  static const String columnAreaCode = 'areaCode';
  static const String columnUscno = 'uscno';
  static const String columnScno = 'scno';
  static const String columnName = 'name';
  static const String columnCat = 'cat';

  factory NonAglUnmappedServicesDb() => _instance;

  NonAglUnmappedServicesDb._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'non_agl_unmapped.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnEroCode TEXT,
        $columnSectionCode TEXT,
        $columnEroSecCode TEXT,
        $columnAreaCode TEXT,
        $columnUscno TEXT UNIQUE,
        $columnScno TEXT,
        $columnName TEXT,
        $columnCat TEXT
      )
    ''');
  }

  // Insert or replace services
  Future<void> insertUnMappedServices(List<UploadMappedService> services) async {
    final db = await database;
    final batch = db.batch();

    for (final service in services) {
      batch.insert(
        tableName,
        service.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  // Get all services
  Future<List<UploadMappedService>> getUnMappedServices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return UploadMappedService.fromJson(maps[i]);
    });
  }

  // Clear all services
  Future<void> clearUnMappedServices() async {
    final db = await database;
    await db.delete(tableName);
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}