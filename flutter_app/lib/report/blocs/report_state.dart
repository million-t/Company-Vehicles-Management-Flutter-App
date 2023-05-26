import 'package:equatable/equatable.dart';

import '../models/report_model.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportLoading extends ReportState {}

class ReportOperationSuccess extends ReportState {
  final Iterable<Report> reports;

  const ReportOperationSuccess([this.reports = const []]);

  @override
  List<Object> get props => [reports];
}

class ReportOperationFailure extends ReportState {
  final Object error;

  const ReportOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
