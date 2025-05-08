import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/uebung.dart';
import '../../logic/uebungen_provider.dart';

class UebungTile extends StatefulWidget {
  final Uebung uebung;

  const UebungTile({super.key, required this.uebung});

  @override
  State<UebungTile> createState() => _UebungTileState();
}

class _UebungTileState extends State<UebungTile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.uebung.gewicht.toStringAsFixed(1)
    );
  }

  @override
  void didUpdateWidget(UebungTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uebung.gewicht != widget.uebung.gewicht) {
      _controller.text = widget.uebung.gewicht.toStringAsFixed(1);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _updateGewichtFromText(BuildContext context) {
    final provider = Provider.of<UebungenProvider>(context, listen: false);
    final parsed = double.tryParse(_controller.text.replaceAll(',', '.'));

    if (parsed != null && parsed >= 0) {
      provider.changeGewicht(widget.uebung, parsed - widget.uebung.gewicht);
    } else {
      _controller.text = widget.uebung.gewicht.toStringAsFixed(1); // Rücksetzen bei ungültiger Eingabe
    }
  }

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<UebungenProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.uebung.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => provider.changeGewicht(widget.uebung, -2.5),
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
              onPressed: () => provider.changeGewicht(widget.uebung, 2.5),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => provider.removeUebung(widget.uebung),
            ),
          ],
          )
        )
    );
  }
}