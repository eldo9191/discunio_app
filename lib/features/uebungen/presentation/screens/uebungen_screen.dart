import 'package:discunio/features/uebungen/data/models/uebung.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/uebungen_provider.dart';
import '../widgets/uebung_tile.dart';

class UebungenScreen extends StatelessWidget {
  const UebungenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Übungen')),
      body: Consumer<UebungenProvider>(
        builder: (context, provider, _) {
          final uebungen = provider.uebungen;

          return ListView.builder(
            itemCount: uebungen.length,
            itemBuilder: (context, index) {
              return UebungTile(uebung: uebungen[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final neueUebung = Uebung(
            name: 'Bankdrücken',
            beschreibung: 'Brustübung',
            gewicht: 20.0,
            muskel: Muskelgruppe.brust,
          );
          Provider.of<UebungenProvider>(context, listen: false).addUebung(neueUebung);
        },
        child: const Icon(Icons.add)
      )
    );
  }
}