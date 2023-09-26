import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app/blocs/workout_cubit.dart';
import 'package:gym_app/models/workout.dart';
import 'package:gym_app/screens/home_page.dart';

void main() {
  runApp(const WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Workouts',
      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: const TextTheme(
              // bodyText2: TextStyle(color: Color.fromARGB(255, 66, 74, 96))
              bodyMedium: TextStyle(color: Colors.deepPurple))),
      home: BlocProvider(
        create: (BuildContext context) {
          WorkoutCubit workoutsCubit = WorkoutCubit();
          if (workoutsCubit.state.isEmpty) {
            workoutsCubit.getWorkouts();
          }
          return workoutsCubit;
        },
        child: BlocBuilder<WorkoutCubit, List<Workout>>(
          builder: (context, state) {
            return const HomePage();
          },
        ),
      ),
      //     MultiBlocProvider(
      //   providers: [
      //     BlocProvider(
      //       create: (BuildContext context) {
      //         WorkoutCubit workoutsCubit = WorkoutCubit();
      //         if (workoutsCubit.state.isEmpty) {
      //           workoutsCubit.getWorkouts();
      //         }
      //         return workoutsCubit;
      //       },
      //     ),
      //     BlocProvider<WorkoutCubit>(
      //       create: (BuildContext context) => WorkoutCubit(),
      //     )
      //   ],
      //   child:
      //       BlocBuilder<WorkoutCubit, WorkoutState>(builder: (context, state) {
      //     if (state is WorkoutInitial) {
      //       print('initial');
      //       return const HomePage();
      //     } else if (state is WorkoutEditing) {
      //       return const EditWorkoutScreen();
      //     }
      //     return const WorkoutProgress();
      //   }),
      // ),
    );
  }
}
