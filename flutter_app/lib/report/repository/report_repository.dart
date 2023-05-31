import '../data_providers/report_data_provider.dart';
import '../models/report_model.dart';
import '../../util/local_provider.dart';

class ReportRepository {
  final ReportDataProvider dataProvider = ReportDataProvider();
  LocalDb localDb = LocalDb();
  ReportRepository();

  Future<Report> create(Report report, String token) async {
    return dataProvider.create(report, token);
  }

  Future<Report> update(String id, Report report, String token) async {
    return dataProvider.update(id, report, token);
  }

  Future<List<Report>> getAllToManager(String token) async {
    try {
      final remote = await dataProvider.getAllToManager(token);
      await localDb
          .saveReports(remote.map((report) => report.toJson()).toList());
      return remote;
    } catch (_) {
      final localData = await localDb.getReports();
      return localData;
    }
  }

  Future<List<Report>> getAllByDriver(String token) async {
    try {
      final remote = await dataProvider.getAllByDriver(token);
      await localDb
          .saveReports(remote.map((report) => report.toJson()).toList());
      return remote;
    } catch (_) {
      final localData = await localDb.getReports();
      return localData;
    }
  }

  Future<void> delete(String id, String token) async {
    dataProvider.delete(id, token);
  }
}
