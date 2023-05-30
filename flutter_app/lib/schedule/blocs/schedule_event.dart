import 'package:equatable/equatable.dart';

import '../models/schedule_model.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleLoad extends ScheduleEvent {
  const ScheduleLoad();

  @override
  List<Object> get props => [];
}

class ScheduleCreate extends ScheduleEvent {
  final Schedule schedule;

  const ScheduleCreate(this.schedule);

  @override
  List<Object> get props => [schedule];

  @override
  String toString() => 'Schedule Created {schedule Id: ${schedule.id}';
}

class ScheduleUpdate extends ScheduleEvent {
  final String id;
  final Schedule schedule;

  const ScheduleUpdate(this.id, this.schedule);

  @override
  List<Object> get props => [id, schedule];

  @override
  String toString() => 'Schedule Updated {schedule Id: $id}';
}

class ScheduleDelete extends ScheduleEvent {
  final String id;

  const ScheduleDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Schedule Deleted {schedule Id: $id}';

  @override
  bool? get stringify => true;
}
