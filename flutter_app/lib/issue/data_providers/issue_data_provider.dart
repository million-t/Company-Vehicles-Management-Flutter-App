import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../util/serverIp.dart';
import '../models/issueModel.dart';

class IssueDataProvider {
  static final String _baseUrl = "${Server().ip}/issue";

  Future<Issue> create(Issue issue, String token) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": issue.managerId,
          "driver_name": issue.driverName,
          "content": issue.content,
          "driver_id": issue.driverId,
        }));

    if (response.statusCode == 200) {
      return Issue.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create Report");
    }
  }

  Future<Issue> getIssue(String id, String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode == 200) {
      return Issue.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Issue failed");
    }
  }

  Future<List<Issue>> getAllByDriver(String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/driver"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode == 200) {
      final issues = jsonDecode(response.body) as List;
      return issues.map((c) => Issue.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Issues.");
    }
  }

  Future<List<Issue>> getAllToManager(String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/manager"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode == 200) {
      print('check check');
      final issues = jsonDecode(response.body) as List;
      return issues.map((c) => Issue.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Reports.");
    }
  }

  Future<Issue> update(String id, Issue issue, String token) async {
    final response = await http.patch(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "status": issue.status,
          "response": issue.response,
          "content": issue.content,
        }));

    if (response.statusCode == 200) {
      return Issue.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the issue");
    }
  }

  Future<void> delete(String id, String token) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{"Authorization": token});

    if (response.statusCode != 200) {
      throw Exception("Field to delete the issue");
    }
    return;
  }
}
