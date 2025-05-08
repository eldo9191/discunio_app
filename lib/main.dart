import 'package:discunio/features/uebungen/logic/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/uebungen/presentation/screens/exercises_screen.dart';

void main() {
  runApp(const DiscunioApp());
}

class DiscunioApp extends StatelessWidget {
  const DiscunioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ExerciseProvider(),
      child: MaterialApp(
        title: 'Discunio',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        home: const ExercisesScreen(),
      ),
    );
  }
}
