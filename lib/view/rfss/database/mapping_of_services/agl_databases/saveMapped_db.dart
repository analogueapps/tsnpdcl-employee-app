import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/rfss/model/save_mapped_model.dart';


class ServiceDatabaseHelper {
  static final ServiceDatabaseHelper instance = ServiceDatabaseHelper._init();
  static Database? _database;

  ServiceDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('services.db');
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
    const String createTable = '''
    CREATE TABLE unmapped_services (
      uscno TEXT PRIMARY KEY,
      digitalDtrStructureCode TEXT,
      latitude REAL,
      longitude REAL,
      unAuthorisedLoadInHp REAL,
      areaCode TEXT,
      authorisationFlag TEXT,
      farmerName TEXT
    )
    ''';

    await db.execute(createTable);
  }

  Future<List<UnMappedService>> getUnMappedServices() async {
    final db = await database;
    final maps = await db.query(
      'unmapped_services',
      where: 'digitalDtrStructureCode IS NOT NULL',
    );

    return maps.map((map) => UnMappedService.fromMap(map)).toList();
  }

  Future<void> deleteUnMappedService(String uscno) async {
    final db = await database;
    await db.delete(
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