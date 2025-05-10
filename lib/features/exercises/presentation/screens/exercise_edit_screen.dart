import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/exercise.dart';
import '../../logic/exercise_provider.dart';

class ExerciseEditScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseEditScreen({super.key, required this.exercise});

  @override
  State<ExerciseEditScreen> createState() => _ExerciseEditScreenState();
}

class _ExerciseEditScreenState extends State<ExerciseEditScreen> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController weightController;
  late MuscleGroup muscleGroup;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.exercise.name);
    descriptionController = TextEditingController(text: widget.exercise.description);
    weightController = TextEditingController(text: widget.exercise.weight.toString());
    muscleGroup = widget.exercise.muscleGroup;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _save() {
    final updatedExercise = Exercise(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      weight: double.tryParse(weightController.text.replaceAll(',', '.')) ?? widget.exercise.weight,
      muscleGroup: muscleGroup
    );

    final provider = Provider.of<ExerciseProvider>(context, listen: false);
    provider.updateExercise(widget.exercise, updatedExercise);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Übung bearbeiten')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Beschreibung'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Gewicht (kg)'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<MuscleGroup>(
              value: muscleGroup,
              onChanged: (value) => setState(() {
                if (value != null) muscleGroup = value;
              }),
              items: MuscleGroup.values
                  .map((g) => DropdownMenuItem(
                        value: g,
                        child: Text(g.name),
                      ))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Muskelgruppe'),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.save),
              label: const Text('Speichern'),
            ),
          ],
        ),
      ),
    );
  }
}