import '../data_providers/issue_data_provider.dart';
import '../models/issueModel.dart';

class IssueRepository {
  final IssueDataProvider dataProvider = IssueDataProvider();
  IssueRepository();

  Future<Issue> create(Issue issue, String token) async {
    return dataProvider.create(issue, token);
  }

  Future<Issue> update(String id, Issue issue, String token) async {
    return dataProvider.update(id, issue, token);
  }

  Future<List<Issue>> getAllToManager(String token) async {
    return dataProvider.getAllToManager(token);
  }

  Future<List<Issue>> getAllByDriver(String token) async {
    return dataProvider.getAllByDriver(token);
  }

  Future<void> delete(String id, String token) async {
    dataProvider.delete(id, token);
  }
}
