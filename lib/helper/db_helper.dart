import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  // create database

  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(join(dbPath, 'mydb.db'),
        onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE events(date TEXT,event Text)",
      );
      await db.execute(
        "CREATE TABLE hadees(hadees TEXT)",
      );
      await db.execute(
        "CREATE TABLE localevents(date TEXT,event Text)",
      );
    }, version: 1);
  }

  //events crud

  static Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * from events");
  }

  static Future<void> insertEvent(String date, String event) async {
    final data = {
      "date": date,
      "event": event,
    };
    final db = await DBHelper.database();
    db.insert(
      "events",
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteEvents() async {
    final db = await DBHelper.database();
    await db.rawDelete("DELETE from events", []);
  }

  //localevents crud

  static Future<List<Map<String, dynamic>>> getLocalEvents() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * from localevents");
  }

  static Future<void> insertLocalEvent(String date, String event) async {
    final data = {
      "date": date,
      "event": event,
    };
    final db = await DBHelper.database();
    db.insert(
      "localevents",
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteLocalEvents() async {
    final db = await DBHelper.database();
    await db.rawDelete("DELETE from events", []);
  }

//hadees crud

  static Future<List<Map<String, dynamic>>> getHadees() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * from hadees");
  }

  static Future<void> insertHadees(String hadees) async {
    final data = {
      "hadees": hadees,
    };
    final db = await DBHelper.database();
    db.insert(
      "hadees",
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteHadees() async {
    final db = await DBHelper.database();
    await db.rawDelete("DELETE from hadees", []);
  }
}
