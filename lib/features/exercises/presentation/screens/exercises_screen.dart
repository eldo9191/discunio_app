import 'package:discunio/features/exercises/presentation/widgets/add_exercise_dialog.dart';
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
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddExerciseDialog()
          );  
        },
        child: const Icon(Icons.add)
      )
    );
  }
}