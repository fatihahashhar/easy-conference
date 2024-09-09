import 'package:easyconference/models/conference.dart';
import 'package:easyconference/models/specialize.dart';
import 'package:easyconference/models/login.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'conference.db');
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store brands
  // and a table to store shoes.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {conference_info} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE conference_info(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, role TEXT, areaId INTEGER, FOREIGN KEY (areaId) REFERENCES specialize_area(id) ON DELETE SET NULL)',
    );
    // Run the CREATE {specialize_area} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE specialize_area(id INTEGER PRIMARY KEY, area TEXT)',
    );
    await db.execute(
      """
     INSERT INTO  specialize_area ('id', 'area')
     VALUES (1, 'Artificial Intelligence')
    """,
    );
    await db.execute(
      """
     INSERT INTO  specialize_area ('id', 'area')
     VALUES (2, 'Data Mining')
    """,
    );
    await db.execute(
      """
     INSERT INTO  specialize_area ('id', 'area')
     VALUES (3, 'Computer Security')
    """,
    );
    await db.execute(
      """
     INSERT INTO  specialize_area ('id', 'area')
     VALUES (4, 'Internet of Things')
    """,
    );
    await db.execute(
      """
     INSERT INTO  specialize_area ('id', 'area')
     VALUES (5, 'Software Engineering')
    """,
    );
    // Run the CREATE {login} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE login(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
    );
  }

  // Define a function that inserts Conference Info into the database
  Future<void> insertConferenceInfo(Conference conference) async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Insert the Brand into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'conference_info',
      conference.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the Conference Info from the conference_info table.
  Future<List<Conference>> conference_info() async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Query the table for all the Brands.
    final List<Map<String, dynamic>> maps = await db.query('conference_info');
    // Convert the List<Map<String, dynamic> into a List<Brand>.
    return List.generate(
        maps.length, (index) => Conference.fromMap(maps[index]));
  }

  // A method that updates a Conference Info from the conference_info table.
  Future<void> updateConferenceInfo(Conference conference) async {
    final db = await _databaseService.database;
    await db.update('conference_info', conference.toMap(),
        where: 'id = ?', whereArgs: [conference.id]);
  }

  // A method that deletes a Conference Info from the conference_info table.
  Future<void> deleteConferenceInfo(int id) async {
    final db = await _databaseService.database;
    await db.delete('conference_info', where: 'id = ?', whereArgs: [id]);
  }

  // A method that retrieves all the specialize area from the conference_info table.
  Future<List<SpecializationArea>> specialize_area() async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Query the table for all the Brands.
    final List<Map<String, dynamic>> maps = await db.query('specialize_area');
    // Convert the List<Map<String, dynamic> into a List<Brand>.
    return List.generate(
        maps.length, (index) => SpecializationArea.fromMap(maps[index]));
  }

  // A method that updates a specialize area from the conference_info table.
  Future<void> updateSpecializationArea(SpecializationArea area) async {
    final db = await _databaseService.database;
    await db.update('specialize_area', area.toMap(),
        where: 'id = ?', whereArgs: [area.id]);
  }

  // A method that deletes a specialize area from the conference_info table.
  Future<void> deleteSpecializationArea(int id) async {
    final db = await _databaseService.database;
    await db.delete('specialize_area', where: 'id = ?', whereArgs: [id]);
  }

  Future<SpecializationArea> area(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('specialize_area', where: 'id = ?', whereArgs: [id]);
    return SpecializationArea.fromMap(maps[0]);
  }

  // Define a function that inserts login info into the database
  Future<void> insertLogin(Login login) async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Insert the login info into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'login',
      login.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Login> login(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('login', where: 'id = ?', whereArgs: [id]);
    return Login.fromMap(maps[0]);
  }

  Future<String?> getUserID(String username) async {
    final db = await _databaseService.database;
    String sql = "SELECT id FROM login WHERE username = '$username'";
    var dbQuery = await db.rawQuery(sql);
    if (dbQuery.isNotEmpty) {
      String result = dbQuery.first.values.first.toString();
      return result;
    } else {
      return null;
    }
  }

  Future<int?> checkLogin(String username, String password) async {
    final db = await _databaseService.database;
    var result = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT COUNT (*) FROM login WHERE username = '$username' AND password = '$password'"));
    return result;
  }
}
