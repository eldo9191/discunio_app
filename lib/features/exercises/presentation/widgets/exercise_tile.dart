import 'package:discunio/features/exercises/presentation/screens/exercise_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/exercise.dart';
import '../../logic/exercise_provider.dart';

class ExerciseTile extends StatefulWidget {
  final Exercise exercise;

  const ExerciseTile({super.key, required this.exercise});

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.exercise.weight.toStringAsFixed(1)
    );
  }

  @override
  void didUpdateWidget(ExerciseTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exercise.weight != widget.exercise.weight) {
      _controller.text = widget.exercise.weight.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _updateGewichtFromText(BuildContext context) {
    final provider = Provider.of<ExerciseProvider>(context, listen: false);
    final parsed = double.tryParse(_controller.text.replaceAll(',', '.'));

    if (parsed != null && parsed >= 0) {
      provider.changeWeight(widget.exercise, parsed - widget.exercise.weight);
    } else {
      _controller.text = widget.exercise.weight.toStringAsFixed(1); // Rücksetzen bei ungültiger Eingabe
    }
  }

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<ExerciseProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (_) => ExerciseEditScreen(exercise: widget.exercise)
            ),
          );
        },
        child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.exercise.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => provider.changeWeight(widget.exercise, -2.5),
            ),
            SizedBox(
              width: 70,
              child: TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _updateGewichtFromText(context),
                onEditingComplete: () => _updateGewichtFromText(context),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => provider.changeWeight(widget.exercise, 2.5),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => provider.removeExercise(widget.exercise),
            ),
          ],
          )
        ),
      )
      
        
    );
  }
}