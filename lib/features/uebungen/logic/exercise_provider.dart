import 'package:flutter/material.dart';
import '../data/models/exercise.dart';


class ExerciseProvider with ChangeNotifier {
  final List<Exercise> _exercises = [];

  List<Exercise> get excercises => List.unmodifiable(_exercises);

  void addExercise(Exercise exercise) {
    _exercises.add(exercise);
    notifyListeners();
  }

  void removeExercise(Exercise exercise) {
    _exercises.remove(exercise);
    notifyListeners();
  }

  void changeExercise(Exercise exercise, double delta) {
    final index = _exercises.indexOf(exercise);
    if (index != -1) {
      final newExercise = Exercise(
        name: exercise.name,
        description: exercise.description,
        weight: (exercise.weight + delta).clamp(0, double.infinity),
        muscleGroup: exercise.muscleGroup
      );
      _exercises[index] = newExercise;
      notifyListeners();
    }
  }
}