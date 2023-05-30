import 'package:equatable/equatable.dart';

import '../models/schedule_model.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object> get props => [];
}

class ScheduleLoading extends ScheduleState {}

class ScheduleOperationSuccess extends ScheduleState {
  final Iterable<Schedule> schedules;

  const ScheduleOperationSuccess([this.schedules = const []]);

  @override
  List<Object> get props => [schedules];
}

class ScheduleOperationFailure extends ScheduleState {
  final Object error;

  const ScheduleOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
