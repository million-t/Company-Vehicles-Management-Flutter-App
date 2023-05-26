import 'package:equatable/equatable.dart';

import '../models/report_model.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class ReportLoad extends ReportEvent {
  const ReportLoad();

  @override
  List<Object> get props => [];
}

class ReportCreate extends ReportEvent {
  final Report report;

  const ReportCreate(this.report);

  @override
  List<Object> get props => [report];

  @override
  String toString() => 'Course Created {course Id: ${report.id}';
}

class ReportUpdate extends ReportEvent {
  final String id;
  final Report report;

  const ReportUpdate(this.id, this.report);

  @override
  List<Object> get props => [id, report];

  @override
  String toString() => 'Report Updated {report Id: $id}';
}

class ReportDelete extends ReportEvent {
  final String id;

  const ReportDelete(this.id);

  @override
  List<Object> get props => [id];

  @override
  toString() => 'Report Deleted {report Id: $id}';

  @override
  bool? get stringify => true;
}
