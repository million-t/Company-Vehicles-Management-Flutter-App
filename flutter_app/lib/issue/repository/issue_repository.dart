import '../data_providers/issue_data_provider.dart';
import '../models/issueModel.dart';
import '../../util/local_provider.dart';

class IssueRepository {
  final IssueDataProvider dataProvider = IssueDataProvider();
  LocalDb localDb = LocalDb();

  IssueRepository();

  Future<Issue> create(Issue issue, String token) async {
    return dataProvider.create(issue, token);
  }

  Future<Issue> update(String id, Issue issue, String token) async {
    return dataProvider.update(id, issue, token);
  }

  Future<List<Issue>> getAllToManager(String token) async {
    try {
      final remote = await dataProvider.getAllToManager(token);
      // await localDb.saveIssues(remote.map((issue) => issue.toJson()).toList());
      return remote;
    } catch (_) {
      return [];
      // final localData = await localDb.getIssues();
      // return localData;
    }
  }

  Future<List<Issue>> getAllByDriver(String token) async {
    try {
      final remote = await dataProvider.getAllByDriver(token);
      // await localDb.saveIssues(remote.map((issue) => issue.toJson()).toList());
      return remote;
    } catch (_) {
      return [];
      final localData = await localDb.getIssues();
      return localData;
    }
  }

  Future<void> delete(String id, String token) async {
    dataProvider.delete(id, token);
  }
}
