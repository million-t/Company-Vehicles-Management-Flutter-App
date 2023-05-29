import 'package:equatable/equatable.dart';

import '../models/issueModel.dart';

abstract class IssueEvent extends Equatable {
  const IssueEvent();
}

class IssueLoad extends IssueEvent {
  const IssueLoad();

  @override
  List<Object> get props => [];
}

class IssueCreate extends IssueEvent {
  final Issue issue;

  const IssueCreate(this.issue);

  @override
  List<Object> get props => [issue];

  @override
  String toString() => 'Issue Created {issue Id: ${issue.id}';
}

class IssueUpdate extends IssueEvent {
  final String id;
  final Issue issue;

  const IssueUpdate(this.id, this.issue);

  @override
  List<Object> get props => [id, issue];

  @override
  String toString() => 'Issue Updated {issue Id: $id}';
}

class IssueDelete extends IssueEvent {
  final String id;

  const IssueDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Issue Deleted {issue Id: $id}';

  @override
  bool? get stringify => true;
}
