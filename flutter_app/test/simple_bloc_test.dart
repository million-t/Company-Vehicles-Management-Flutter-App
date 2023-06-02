import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_app/auth/blocs/blocs.dart';
import 'package:flutter_app/auth/repository/user_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_app/vehicle/repository/vehicle_repository.dart';
import 'package:flutter_app/vehicle/blocs/blocs.dart';
import 'package:flutter_app/issue/blocs/blocs.dart';
import 'package:flutter_app/issue/repository/issue_repository.dart';
import 'package:flutter_app/report/blocs/blocs.dart';
import 'package:flutter_app/report/repository/report_repository.dart';

void main() {
  UserRepository userRepository = UserRepository();
  IssueRepository issueRepository = IssueRepository();
  ReportRepository reportRepository = ReportRepository();
  VehicleRepository vehicleRepository = VehicleRepository();
  group('Auth Bloc', () {
    blocTest(
      'emits [] when no event is added',
      build: () => UserBloc(userRepository: userRepository),
      expect: () => [],
    );
  });

  group('Issue Bloc', () {
    blocTest(
      'emits [] when no event is added',
      build: () => IssueBloc(issueRepository: issueRepository),
      expect: () => [],
    );
  });

  group('Vehicle Bloc', () {
    blocTest(
      'emits [] when no event is added',
      build: () => VehicleBloc(vehicleRepository: vehicleRepository),
      expect: () => [],
    );
  });

  group('Report Bloc', () {
    blocTest(
      'emits [] when no event is added',
      build: () => ReportBloc(reportRepository: reportRepository),
      expect: () => [],
    );
  });
}
