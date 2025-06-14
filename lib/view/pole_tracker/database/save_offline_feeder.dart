import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/digital_feeder_entity.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/offline_feeder.dart';



class OFDatabaseHelper {
  static final OFDatabaseHelper instance = OFDatabaseHelper._init();
  static Database? _database;

  OFDatabaseHelper._init();

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
                    insertDate INTEGER,
                    poleListJson TEXT
                  )
                ''');
  }

  Future<void> insertOfflineFeeder(
      OffLineFeeder feeder) async {
    final db = await database;

    await db.insert('offline_feeder', feeder.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<OffLineFeeder?> getOfflineFeeder(String feederCode) async {
    final db = await database;

    final feederResult = await db.query('offline_feeder',
        where: 'feederCode = ?', whereArgs: [feederCode]);

    if (feederResult.isEmpty) return null;


    final feeder = OffLineFeeder.fromJson(feederResult.first);

    print("Feeder Name: ${feeder.feederName}");

    return feeder;
  }

  Future<List<OffLineFeeder>> getAllOfflineFeeders() async {
    final db = await database;
    final result = await db.query('offline_feeder');
    return result.map((json) => OffLineFeeder.fromJson(json)).toList();
  }

  Future<void> deleteOfflineFeeder(String feederCode) async {
    final db = await database;
    await db.delete('offline_feeder',
        where: 'feederCode = ?', whereArgs: [feederCode]);
  }

  Future<void> clearAllOfflineFeeders() async {
    final db = await database;
    await db.delete('offline_feeder');
  }

}