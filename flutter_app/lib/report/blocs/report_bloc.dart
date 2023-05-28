import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/repository/user_repository.dart';
import '../../auth/data_providers/remote_user_data_provider.dart';
import '../models/report_model.dart';
import '../repository/report_repository.dart';

import 'blocs.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ReportRepository reportRepository;
  final UserRepository userRepository = UserRepository();

  ReportBloc({required this.reportRepository}) : super(ReportLoading()) {
    on<ReportLoad>((event, emit) async {
      try {
        String? token = await userRepository.getToken();
        // token = token.toString();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        final List<Report> reports;
        if (type == "manager") {
          reports = await reportRepository.getAllToManager(token.toString());
        } else if (type == "driver") {
          reports = await reportRepository.getAllByDriver(token.toString());
        } else {
          throw Exception("Unauthenticated.");
        }

        emit(ReportOperationSuccess(reports));
      } catch (error) {
        emit(ReportOperationFailure(error));
      }
    });

    on<ReportCreate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        event.report.driverName = userJson['name'];
        event.report.driverId = userJson['_id'];
        event.report.managerId = userJson['manager_id'];

        await reportRepository.create(event.report, token!);
        final List<Report> reports;
        if (type.toString() == "manager") {
          reports = await reportRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          reports = await reportRepository.getAllByDriver(token.toString());
        } else {
          throw Exception("Unauthenticated.");
        }

        emit(ReportOperationSuccess(reports));
      } catch (error) {
        emit(ReportOperationFailure(error));
      }
    });

    on<ReportUpdate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        event.report.driverName = userJson['name'];
        event.report.driverId = userJson['_id'];
        event.report.managerId = userJson['manager_id'];
        await reportRepository.update(event.id, event.report, token.toString());
        final List<Report> reports;
        if (type.toString() == "manager") {
          reports = await reportRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          reports = await reportRepository.getAllByDriver(token.toString());
        } else {
          throw Error();
        }
        emit(ReportOperationSuccess(reports));
      } catch (error) {
        emit(ReportOperationFailure(error));
      }
    });

    on<ReportDelete>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        await reportRepository.delete(event.id, token.toString());
        final List<Report> reports;
        if (type.toString() == "manager") {
          reports = await reportRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          reports = await reportRepository.getAllByDriver(token.toString());
        } else {
          reports = [];
        }
        emit(ReportOperationSuccess(reports));
      } catch (error) {
        emit(ReportOperationFailure(error));
      }
    });
  }
}
