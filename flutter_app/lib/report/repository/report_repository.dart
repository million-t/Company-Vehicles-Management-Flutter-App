import '../data_providers/report_data_provider.dart';
import '../models/report_model.dart';

class ReportRepository {
  final ReportDataProvider dataProvider = ReportDataProvider();
  ReportRepository();

  Future<Report> create(Report report, String token) async {
    return dataProvider.create(report, token);
  }

  Future<Report> update(String id, Report report, String token) async {
    return dataProvider.update(id, report, token);
  }

  Future<List<Report>> getAllToManager(String token) async {
    return dataProvider.getAllToManager(token);
  }

  Future<List<Report>> getAllByDriver(String token) async {
    return dataProvider.getAllByDriver(token);
  }

  Future<void> delete(String id, String token) async {
    dataProvider.delete(id, token);
  }
}
