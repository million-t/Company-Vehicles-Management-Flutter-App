import 'dart:convert';
import '../../util/serverIp.dart';
import 'package:http/http.dart' as http;

import '../models/report_model.dart';

class ReportDataProvider {
  static final String _baseUrl = "${Server().ip}/report";

  Future<Report> create(Report report, String token) async {
    final http.Response response = await http.post(Uri.parse(_baseUrl),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": report.managerId,
          "driver_name": report.driverName,
          "vehicle_name": report.vehicleName,
          "distance": report.distance,
          "driver_id": report.driverId,
          "litres": report.litres,
          "price": report.price
        }));

    if (response.statusCode == 201) {
      return Report.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Failed to create Report");
    }
  }

  Future<Report> getReport(String id, String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/$id"));

    if (response.statusCode == 200) {
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Fetching Report failed");
    }
  }

  Future<List<Report>> getAllByDriver(String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/driver"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode == 200) {
      final reports = jsonDecode(response.body) as List;
      return reports.map((c) => Report.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Reports.");
    }
  }

  Future<List<Report>> getAllToManager(String token) async {
    final response = await http.get(Uri.parse("$_baseUrl/manager"),
        headers: <String, String>{"Authorization": token});

    if (response.statusCode == 200) {
      final reports = jsonDecode(response.body) as List;
      return reports.map((c) => Report.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch Reports.");
    }
  }

  Future<Report> update(String id, Report report, String token) async {
    final response = await http.patch(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": token
        },
        body: jsonEncode({
          "manager_id": report.managerId,
          "driver_name": report.driverName,
          "vehicle_name": report.vehicleName,
          "distance": report.distance,
          "driver_id": report.driverId,
          "litres": report.litres,
          "price": report.price
        }));

    if (response.statusCode == 200) {
      return Report.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the Report");
    }
  }

  Future<void> delete(String id, String token) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{"Authorization": token});
    if (response.statusCode != 204) {
      throw Exception("Field to delete the Reports");
    }
    return;
  }
}
