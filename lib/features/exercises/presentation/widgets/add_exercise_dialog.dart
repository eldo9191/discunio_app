import 'package:discunio/features/exercises/data/models/exercise.dart';
import 'package:discunio/features/exercises/logic/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExerciseDialog extends StatefulWidget {
  const AddExerciseDialog({super.key});

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialog(); 
}

class _AddExerciseDialog extends State<AddExerciseDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  MuscleGroup _muscleGroup = MuscleGroup.shoulders;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Neue Übung'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name')
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Beschreibung')
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Gewicht'),
              keyboardType: TextInputType.number
            ),
            DropdownButton(
              value: _muscleGroup,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _muscleGroup = value;
                  });
                }
              },
              items: MuscleGroup.values.map((group) {
                  return DropdownMenuItem(
                    value: group,
                    child: Text(group.name) 
                    );
              }).toList(),
            )
          ],
        )
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop,
          child: const Text('Abbrechen')
        ),
        ElevatedButton(
          onPressed : () async {
            final exercise = Exercise(
              name: _nameController.text,
              description: _descriptionController.text,
              weight: double.tryParse(_weightController.text) ?? 0,
              muscleGroup: _muscleGroup
            );
            await Provider.of<ExerciseProvider>(context, listen: false).addExercise(exercise);
            if (context.mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Übung gespeichert')));
            }
          },
          child: const Text('Speichern')
        )
      ],
    );
  }
}
