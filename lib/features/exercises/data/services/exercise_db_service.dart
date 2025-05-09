import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/exercise.dart';

class ExerciseDbService {
  static final ExerciseDbService _instance = ExerciseDbService._internal();
  factory ExerciseDbService() => _instance;

  static Database? _db;

  ExerciseDbService._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'exercises.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE exercises (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            description TEXT,
            weight REAL,
            muscleGroup TEXT
          )
        ''');
      }
    );
  }

  Future<int> insertExercise(Exercise e) async {
    final dbClient = await db;
    return await dbClient.insert('exercises', e.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteExercise(Exercise e) async {
    final dbClient = await db;
    await dbClient.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [e.id]
    );
  }

  Future<void> updateExercise(Exercise e) async {
    final dbClient = await db;
    await dbClient.update(
      'exercises',
      e.toMap(),
      where: "id = ?",
      whereArgs: [e.id]
    );
  }

  Future<List<Exercise>> getAllExercises() async {
    final dbClient = await db;
    final maps = await dbClient.query('exercises');
    
    return maps.map((m) => Exercise.fromMap(m)).toList();
  }
}