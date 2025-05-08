enum MuscleGroup {
  breast,
  ruecken,
  beine,
  bauch,
  schultern,
  arme,
  anderes
}

class Exercise {
 final String name;
 final String description;
 final double weight;
 final MuscleGroup muscleGroup;

 Exercise({
  required this.name,
  required this.description,
  required this.weight,
  required this.muscleGroup
 });
}