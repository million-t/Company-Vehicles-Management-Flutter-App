import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/repository/user_repository.dart';
import '../../auth/data_providers/remote_user_data_provider.dart';
import '../models/schedule_model.dart';
import '../repository/schedule_repository.dart';

import 'blocs.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;
  final UserRepository userRepository = UserRepository();

  ScheduleBloc({required this.scheduleRepository}) : super(ScheduleLoading()) {
    on<ScheduleLoad>((event, emit) async {
      try {
        String? token = await userRepository.getToken();
        // token = token.toString();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        final List<Schedule> schedules;
        if (type == "manager") {
          schedules =
              await scheduleRepository.getAllToManager(token.toString());
        } else if (type == "driver") {
          schedules = await scheduleRepository.getAllByDriver(token.toString());
        } else {
          throw Exception("Unauthenticated.");
        }

        emit(ScheduleOperationSuccess(schedules));
      } catch (error) {
        emit(ScheduleOperationFailure(error));
      }
    });

    on<ScheduleCreate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        // final id = userJson['_'];

        event.schedule.managerId = userJson['_id'];

        await scheduleRepository.create(event.schedule, token!);
        emit(ScheduleLoading());
        final List<Schedule> schedules;
        if (type.toString() == "manager") {
          schedules =
              await scheduleRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          schedules = await scheduleRepository.getAllByDriver(token.toString());
        } else {
          throw Exception("Unauthenticated.");
        }

        emit(ScheduleOperationSuccess(schedules));
      } catch (error) {
        emit(ScheduleOperationFailure(error));
      }
    });

    on<ScheduleUpdate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        await scheduleRepository.update(
            event.id, event.schedule, token.toString());
        final List<Schedule> schedules;
        if (type.toString() == "manager") {
          schedules =
              await scheduleRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          schedules = await scheduleRepository.getAllByDriver(token.toString());
        } else {
          throw Error();
        }
        emit(ScheduleOperationSuccess(schedules));
      } catch (error) {
        emit(ScheduleOperationFailure(error));
      }
    });

    on<ScheduleDelete>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        await scheduleRepository.delete(event.id, token.toString());
        emit(ScheduleLoading());
        final List<Schedule> schedules;
        if (type.toString() == "manager") {
          schedules =
              await scheduleRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          schedules = await scheduleRepository.getAllByDriver(token.toString());
        } else {
          schedules = [];
        }
        emit(ScheduleOperationSuccess(schedules));
      } catch (error) {
        emit(ScheduleOperationFailure(error));
      }
    });
  }
}
