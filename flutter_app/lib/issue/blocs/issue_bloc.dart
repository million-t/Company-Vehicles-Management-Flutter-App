import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/repository/user_repository.dart';
import '../../auth/data_providers/remote_user_data_provider.dart';
import '../models/issueModel.dart';
import '../repository/issue_repository.dart';

import 'blocs.dart';

class IssueBloc extends Bloc<IssueEvent, IssueState> {
  final IssueRepository issueRepository;
  final UserRepository userRepository = UserRepository();

  IssueBloc({required this.issueRepository}) : super(IssueLoading()) {
    on<IssueLoad>((event, emit) async {
      try {
        String? token = await userRepository.getToken();
        // token = token.toString();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        final List<Issue> issues;
        if (type == "manager") {
          issues = await issueRepository.getAllToManager(token.toString());
        } else if (type == "driver") {
          issues = await issueRepository.getAllByDriver(token.toString());
        } else {
          issues = [];
        }

        emit(IssueOperationSuccess(issues));
      } catch (error) {
        emit(IssueOperationFailure(error));
      }
    });

    on<IssueCreate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];
        event.issue.driverName = userJson['name'];
        event.issue.driverId = userJson['_id'];
        event.issue.managerId = userJson['manager_id'];

        await issueRepository.create(event.issue, token!);
        final List<Issue> issues;
        if (type.toString() == "manager") {
          issues = await issueRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          issues = await issueRepository.getAllByDriver(token.toString());
        } else {
          issues = [];
        }

        emit(IssueOperationSuccess(issues));
      } catch (error) {
        emit(IssueOperationFailure(error));
      }
    });

    on<IssueUpdate>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        await issueRepository.update(event.id, event.issue, token.toString());
        final List<Issue> issues;
        if (type.toString() == "manager") {
          issues = await issueRepository.getAllToManager(token.toString());
        } else if (type.toString() == "driver") {
          issues = await issueRepository.getAllByDriver(token.toString());
        } else {
          issues = [];
        }
        emit(IssueOperationSuccess(issues));
      } catch (error) {
        emit(IssueOperationFailure(error));
      }
    });

    on<IssueDelete>((event, emit) async {
      try {
        final token = await userRepository.getToken();
        final user = await userRepository.getUser();
        final userJson = jsonDecode(user);
        final type = userJson['type'];

        await issueRepository.delete(event.id, token.toString());
        // final List<Issue> issues;
        // if (type.toString() == "manager") {
        //   issues = await issueRepository.getAllToManager(token.toString());
        // } else if (type.toString() == "driver") {
        //   issues = await issueRepository.getAllByDriver(token.toString());
        // } else {
        //   issues = [];
        // }
        emit(IssueLoading());
      } catch (error) {
        emit(IssueOperationFailure(error));
      }
    });
  }
}
