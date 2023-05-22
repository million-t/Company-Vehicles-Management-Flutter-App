import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/schedule_repository.dart';
import 'blocs.dart';
import '../models/schedule.dart';

import 'dart:async';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleLoading()) {
    on<ScheduleLoad>((event, emit) async {
      emit(ScheduleLoading());
      try {
        final courses = await scheduleRepository.fetchAll();
        emit(ScheduleOperationSuccess(courses));
      } catch (error) {
        emit(ScheduleOperationFailure(error));
      }
    });
  }
}
// class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
//   final ScheduleRepository scheduleRepository;

//   ScheduleBloc({required this.scheduleRepository}) : super(ScheduleLoading()) {
//     on<ScheduleLoad>((event, emit) async {
//       emit(ScheduleLoading());
//       try {
//         final schedules = await scheduleRepository.getSchedules();
//         emit(ScheduleOperationSuccess(schedules));
//       } catch (error) {
//         emit(ScheduleOperationFailure(error));
//       }
//     });
//   }



  // Stream<List<Schedule>> getSchedules() async* {
  //   yield* Stream.fromFuture(_repository.getSchedules());
  // }
// }
// ==========================================
// class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
//   final ScheduleRepository scheduleRepository;

//   ScheduleBloc({required this.scheduleRepository}) : super(ScheduleLoading()) {
//     on<ScheduleLoad>((event, emit) async {
//       emit(ScheduleLoading());
//       try {
//         final courses = await scheduleRepository.fetchAll();
//         emit(ScheduleOperationSuccess(courses));
//       } catch (error) {
//         emit(ScheduleOperationFailure(error));
//       }
//     });
//   }
// }
