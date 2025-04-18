import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_agl_data_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

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
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE unmapped_services(
            uscno TEXT PRIMARY KEY,
            structure TEXT,
            lat REAL,
            lon REAL,
            loadInHp REAL,
            areaCode TEXT,
            authorisationFlag TEXT,
            farmerName TEXT
          )
        ''');
      },
    );
  }

  // Insert or update services
  Future<void> upsertServices(List<SaveAglDataModel> services) async {
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
  Future<List<SaveAglDataModel>> getAllServices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('unmapped_services');
    return List.generate(maps.length, (i) {
      return SaveAglDataModel.fromJson(maps[i]);
    });
  }

  // Get services by area code
  Future<List<SaveAglDataModel>> getServicesByArea(String areaCode) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'unmapped_services',
      where: 'areaCode = ?',
      whereArgs: [areaCode],
    );
    return List.generate(maps.length, (i) => SaveAglDataModel.fromJson(maps[i]));
  }

  // Delete all services
  Future<int> deleteAllServices() async {
    final db = await database;
    return await db.delete('unmapped_services');
  }

  // Delete single service
  Future<int> deleteService(String uscno) async {
    final db = await database;
    return await db.delete(
      'unmapped_services',
      where: 'uscno = ?',
      whereArgs: [uscno],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}