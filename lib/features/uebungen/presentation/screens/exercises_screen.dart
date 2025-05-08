import 'package:discunio/features/uebungen/data/models/exercise.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/exercise_provider.dart';
import '../widgets/uebung_tile.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Übungen')),
      body: Consumer<ExerciseProvider>(
        builder: (context, provider, _) {
          final uebungen = provider.excercises;

          return ListView.builder(
            itemCount: uebungen.length,
            itemBuilder: (context, index) {
              return ExerciseTile(exercise: uebungen[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final neueUebung = Exercise(
            name: 'Bankdrücken',
            description: 'Brustübung',
            weight: 20.0,
            muscleGroup: MuscleGroup.breast,
          );
          Provider.of<ExerciseProvider>(context, listen: false).addExercise(neueUebung);
        },
        child: const Icon(Icons.add)
      )
    );
  }
}