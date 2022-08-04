import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCRUD {
  DatabaseCRUD();

  static Future<Database> initDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'taskDatabase.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,subtitle TEXT)');
      },
      version: 1,
    );
    return database;
  }

  static insertTask(String title, String subtitle) async {
    final db = await DatabaseCRUD.initDatabase();
    final data = {'title': title, 'subtitle': subtitle};

    await db.insert(
      'task',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseCRUD.initDatabase();
    return db.query('task', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> searchTask() async {
    final db = await DatabaseCRUD.initDatabase();
    return db.query('task', orderBy: 'id');
  }

  static Future deleteItem(int id) async {
    final db = await DatabaseCRUD.initDatabase();
    try {
      await db.delete("task", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static updateItem(int id, String title, String subtitle) async {
    final db = await DatabaseCRUD.initDatabase();
    final data = {'title': title, 'subtitle': subtitle};
    try {
      await db.update("task", data, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
