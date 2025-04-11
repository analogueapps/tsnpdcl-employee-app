import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tsnpdcl_employee/view/gis_ids/model/gis_individual_model.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('gis_survey.db');
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
CREATE TABLE gis_survey_data (
  surveyId INTEGER PRIMARY KEY,
  sectionCode TEXT,
  sanctionNo TEXT,
  beforeLat REAL,
  pbeforeLon REAL,
  beforeImageUrl TEXT,
  surveyorId TEXT,
  timeOfSurveyor TEXT,
  feederCode TEXT,
  lineType TEXT,
  dateOfBeforeMarked TEXT,
  feederName TEXT,
  status TEXT,
  monthYear TEXT,
  workDescription TEXT,
  circleCode TEXT,
  circle TEXT,
  divisionCode TEXT,
  division TEXT,
  subdivision TEXT,
  subdivisionCode TEXT,
  section TEXT,
  gisId INTEGER,
  sapUploadFlag TEXT,
  pointVoltage TEXT
)
''');
  }

  // Insert a GisSurveyData object
  Future<void> insertGisSurveyData(GisSurveyData data) async {
    final db = await database;
    await db.insert(
      'gis_survey_data',
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace if surveyId exists
    );
  }

  // Retrieve all GisSurveyData objects
  Future<List<GisSurveyData>> getAllGisSurveyData() async {
    final db = await database;
    final maps = await db.query('gis_survey_data');

    return maps.map((map) => GisSurveyData.fromJson(map)).toList();
  }

  // Delete a GisSurveyData by surveyId
  Future<void> deleteGisSurveyData(int surveyId) async {
    final db = await database;
    await db.delete(
      'gis_survey_data',
      where: 'surveyId = ?',
      whereArgs: [surveyId],
    );
  }

  Future close() async {
    final db = await database;
    _database = null;
    db.close();
  }
}