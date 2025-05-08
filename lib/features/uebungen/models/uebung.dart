enum Muskelgruppe {
  brust,
  ruecken,
  beine,
  bauch,
  schultern,
  arme,
  anderes
}

class Uebung {
 final String name;
 final String beschreibung;
 final double gewicht;
 final Muskelgruppe muskel;

 Uebung({
  required this.name,
  required this.beschreibung,
  required this.gewicht,
  required this.muskel
 });
}