import 'package:equatable/equatable.dart';

import '../models/issueModel.dart';

abstract class IssueState extends Equatable {
  const IssueState();

  @override
  List<Object> get props => [];
}

class IssueLoading extends IssueState {}

class IssueOperationSuccess extends IssueState {
  final Iterable<Issue> issues;

  const IssueOperationSuccess([this.issues = const []]);

  @override
  List<Object> get props => [issues];
}

class IssueOperationFailure extends IssueState {
  final Object error;

  const IssueOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
