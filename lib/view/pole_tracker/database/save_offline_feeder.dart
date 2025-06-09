import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_entity.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/offline_feeder.dart';



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('offline_feeder.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE offline_feeder (
        feederCode TEXT PRIMARY KEY,
        feederName TEXT,
        ssCode TEXT,
        ssName TEXT,
        voltageLevel TEXT,
        insertDate INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE digital_feeder (
        id INTEGER PRIMARY KEY,
        poleNum TEXT,
        feederCode TEXT,
        FOREIGN KEY (feederCode) REFERENCES offline_feeder (feederCode)
      )
    ''');
  }

  Future<void> insertOfflineFeeder(
      OffLineFeeder feeder, List<DigitalFeederEntity> digitalList) async {
    final db = await database;

    await db.insert('offline_feeder', feeder.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    // Clear old poles
    await db.delete('digital_feeder',
        where: 'feederCode = ?', whereArgs: [feeder.feederCode]);

    // Insert new poles
    for (final pole in digitalList) {
      await db.insert('digital_feeder', pole.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<OffLineFeeder?> getOfflineFeeder(String feederCode) async {
    final db = await database;

    final feederResult = await db.query('offline_feeder',
        where: 'feederCode = ?', whereArgs: [feederCode]);

    if (feederResult.isEmpty) return null;

    final polesResult = await db.query('digital_feeder',
        where: 'feederCode = ?', whereArgs: [feederCode]);

    final feeder = OffLineFeeder.fromJson(feederResult.first);
    final poles =
    polesResult.map((e) => DigitalFeederEntity.fromJson(e)).toList();

    // Combine if needed or return separately
    print("Feeder Name: ${feeder.feederName}, Poles Count: ${poles.length}");

    return feeder;
  }

  Future<List<OffLineFeeder>> getAllOfflineFeeders() async {
    final db = await database;
    final result = await db.query('offline_feeder');
    return result.map((json) => OffLineFeeder.fromJson(json)).toList();
  }

  Future<void> deleteOfflineFeeder(String feederCode) async {
    final db = await database;
    await db.delete('digital_feeder',
        where: 'feederCode = ?', whereArgs: [feederCode]);
    await db.delete('offline_feeder',
        where: 'feederCode = ?', whereArgs: [feederCode]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
