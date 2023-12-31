import 'package:equatable/equatable.dart';

import 'package:gym_app/models/exercise.dart';

class Workout extends Equatable {
  final String? title;
  final List<Exercise> exercises;

  const Workout({
    required this.title,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;
    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }
    return Workout(title: json['title'] as String?, exercises: exercises);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "exercises ": exercises,
      };

  Workout copyWith({String? title}) => Workout(
        title: title ?? this.title,
        exercises: exercises,
      );

  int getTotal() => exercises.fold(
      0,
      (previousValue, element) =>
          previousValue + element.duration! + element.prelude!);

  Exercise getCurrentExercise(int? elapsed) =>
      exercises.lastWhere((element) => element.startTime! <= elapsed!);

  @override
  List<Object?> get props => [title, exercises];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'exercises': exercises.map((x) => x.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      title: map['title'] != null ? map['title'] as String : null,
      exercises: List<Exercise>.from(
        (map['exercises'] as List<int>).map<Exercise>(
          (x) => Exercise.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
