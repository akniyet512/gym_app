import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/models/workout.dart';

class WorkoutCubit extends Cubit<List<Workout>> {
  WorkoutCubit() : super([]);

  Future<void> getWorkouts() async {
    final List<Workout> workouts = [];
    final dynamic workoutsJson =
        jsonDecode(await rootBundle.loadString("assets/json/workouts.json"));
    for (dynamic json in (workoutsJson as Iterable)) {
      workouts.add(Workout.fromJson(json));
    }
    emit(workouts);
  }
}
