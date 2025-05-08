import 'package:discunio/features/exercises/data/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/exercise_provider.dart';
import '../widgets/exercise_tile.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Übungen')),
      body: Consumer<ExerciseProvider>(
        builder: (context, provider, _) {
          final exercises = provider.exercises;

          return ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              return ExerciseTile(exercise: exercises[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExercise = Exercise(
            name: 'Bankdrücken',
            description: 'Brustübung',
            weight: 20.0,
            muscleGroup: MuscleGroup.breast,
          );
          await Provider.of<ExerciseProvider>(context, listen: false).addExercise(newExercise);
        },
        child: const Icon(Icons.add)
      )
    );
  }
}