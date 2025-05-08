import 'package:flutter/material.dart';
import '../data/models/exercise.dart';
import '../data/services/exercise_db_service.dart';

class ExerciseProvider with ChangeNotifier {
  final List<Exercise> _exercises = [];
  final ExerciseDbService _db = ExerciseDbService();

  List<Exercise> get exercises => List.unmodifiable(_exercises);

  ExerciseProvider() {
    debugPrint('[ExerciseProvider] Konstruktor gestartet');
    _loadFromDb();
  }

  Future<void> _loadFromDb() async {
    final exercises = await _db.getAllExercises();
    _exercises.clear();
    _exercises.addAll(exercises);
    notifyListeners();
  }

  Future<void> addExercise(Exercise exercise) async {
    
    try {
      _exercises.add(exercise);
      await _db.insertExercise(exercise);
      notifyListeners();
    } catch (e, stack) {
      debugPrint('[addExercise] Fehler: $e');
      debugPrint('[addExercise] Stacktrace: $stack');
    }
    
  }

  Future<void> removeExercise(Exercise exercise) async {
    _exercises.remove(exercise);
    await _db.deleteExercise(exercise);
    notifyListeners();
  }

  Future<void> updateExercise(Exercise old, Exercise newExercise) async {
    final index = _exercises.indexWhere((e) => e.name == old.name);

    if (index != -1) {
      _exercises[index] = newExercise;
      await _db.updateExercise(newExercise);
      notifyListeners();
    }
  }

  Future<void> changeWeight(Exercise exercise, double delta) async {
    final index = _exercises.indexWhere((e) => e.name == exercise.name);
    if (index == -1) {
      return;
    }

    final newExercise = Exercise(
      name: exercise.name,
      description: exercise.description,
      weight: (exercise.weight + delta).clamp(0.0, 999.0),
      muscleGroup: exercise.muscleGroup
    );

    _exercises[index] = newExercise;
    await _db.updateExercise(newExercise);
    notifyListeners();
  }
}