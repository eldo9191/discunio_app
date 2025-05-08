import 'package:flutter/material.dart';
import '../data/models/uebung.dart';


class UebungenProvider with ChangeNotifier {
  final List<Uebung> _uebungen = [];

  List<Uebung> get uebungen => List.unmodifiable(_uebungen);

  void addUebung(Uebung uebung) {
    _uebungen.add(uebung);
    notifyListeners();
  }

  void removeUebung(Uebung uebung) {
    _uebungen.remove(uebung);
    notifyListeners();
  }

  void changeGewicht(Uebung uebung, double delta) {
    final index = _uebungen.indexOf(uebung);
    if (index != -1) {
      final neueUebung = Uebung(
        name: uebung.name,
        beschreibung: uebung.beschreibung,
        gewicht: (uebung.gewicht + delta).clamp(0, double.infinity),
        muskel: uebung.muskel
      );
      _uebungen[index] = neueUebung;
      notifyListeners();
    }
  }
}