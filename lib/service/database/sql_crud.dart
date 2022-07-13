import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskoo/service/model/task.dart';

class DatabaseCRUD{

  DatabaseCRUD();
  // WidgetsFlutterBinding.ensureInitialized();

  static Future<Database> initDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'taskDatabase.db'),

      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,,title TEXT,subtitle TEXT)');
      },
      version: 1,
    );
    return database;
  }


    Future<void> insertTask(String title,String subtitle) async{
      final db = await DatabaseCRUD.initDatabase();
      final data = {'title':title,'subtitle':subtitle};
      
      await db.insert(
          'task',
          data,
          conflictAlgorithm: ConflictAlgorithm.replace,
     );
    }








}