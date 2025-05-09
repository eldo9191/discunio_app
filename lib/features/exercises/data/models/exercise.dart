enum MuscleGroup {
  breast,
  back,
  legs,
  abdomen,
  shoulders,
  arms,
  misc
}

class Exercise {
 int? id;
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'weight': weight,
      'muscleGroup': muscleGroup.name,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      description: map['description'],
      weight: map['weight'],
      muscleGroup: MuscleGroup.values.firstWhere((g) => g.name == map['muscleGroup']),
    );
  }
}