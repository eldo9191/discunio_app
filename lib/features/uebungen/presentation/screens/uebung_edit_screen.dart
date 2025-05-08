import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/uebung.dart';
import '../../logic/uebungen_provider.dart';

class UebungEditScreen extends StatefulWidget {
  final Uebung uebung;

  const UebungEditScreen({super.key, required this.uebung});

  @override
  State<UebungEditScreen> createState() => _UebungEditScreenState();
}

class _UebungEditScreenState extends State<UebungEditScreen> {
  late TextEditingController nameController;
  late TextEditingController beschreibungController;
  late TextEditingController gewichtController;
  late Muskelgruppe muskel;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.uebung.name);
    beschreibungController = TextEditingController(text: widget.uebung.beschreibung);
    gewichtController = TextEditingController(text: widget.uebung.gewicht.toString());
    muskel = widget.uebung.muskel;
  }

  @override
  void dispose() {
    nameController.dispose();
    beschreibungController.dispose();
    gewichtController.dispose();
    super.dispose();
  }

  void _save() {
    final updated = Uebung(
      name: nameController.text.trim(),
      beschreibung: beschreibungController.text.trim(),
      gewicht: double.tryParse(gewichtController.text.replaceAll(',', '.')) ?? widget.uebung.gewicht,
      muskel: muskel
    );

    final provider = Provider.of<UebungenProvider>(context, listen: false);
    provider.removeUebung(widget.uebung);
    provider.addUebung(updated);

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
              controller: beschreibungController,
              decoration: const InputDecoration(labelText: 'Beschreibung'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: gewichtController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Gewicht (kg)'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Muskelgruppe>(
              value: muskel,
              onChanged: (value) => setState(() {
                if (value != null) muskel = value;
              }),
              items: Muskelgruppe.values
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