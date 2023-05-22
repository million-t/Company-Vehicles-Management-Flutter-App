import 'package:equatable/equatable.dart';

import '../models/schedule.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleLoad extends ScheduleEvent {
  const ScheduleLoad();

  @override
  List<Object> get props => [];
}
