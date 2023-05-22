import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/schedule.dart';

class ScheduleRemoteDataProvider {
  static const String _baseUrl =
      'http://localhost:5500/api/schedule/driver/6469c2fb301b3912a6423d20';

  Future<List<Schedule>> fetchAll() async {
    final response = await http.get(Uri.parse(_baseUrl));
    // print('yoohooo');
    // print(response.body);
    final data = jsonDecode(response.body) as List<dynamic>;
    // print(data);
    List<Schedule> result =
        data.map((json) => Schedule.fromJson(json)).toList();
    // print(result);
    return result;
  }
}




// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/schedule.dart';
// // import '';

// class ScheduleDataProvider {
//   static const String _baseUrl =
//       "localhost:5500/api/schedule/manager/6469c2fb301b3912a6423d20";

//   // Future<Schedule> create(Schedule schedule) async {
//   //   final http.Response response = await http.post(Uri.parse(_baseUrl),
//   //       headers: <String, String>{"Content-Type": "application/json"},
//   //       body: jsonEncode({
//   //         "id": schedule.id,
//   //         "vehicle_id": schedule.vehicleId,
//   //         "driver_id": schedule.driverId,
//   //         "manager_id": schedule.managerId,
//   //         "start": schedule.start,
//   //         "end": schedule.end
//   //       }));

//   //   if (response.statusCode == 201) {
//   //     return Schedule.fromJson(jsonDecode(response.body));
//   //   }
//   //   {
//   //     throw Exception("Failed to create schedule");
//   //   }
//   // }

//   // Future<Schedule> fetchByCode(String code) async {
//   //   final response = await http.get(Uri.parse("$_baseUrl/$code"));

//   //   if (response.statusCode == 200) {
//   //     return Schedule.fromJson(jsonDecode(response.body));
//   //   } else {
//   //     throw Exception("Fetching schedule by code failed");
//   //   }
//   // }

//   Future<List<Schedule>> fetchAll() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//     if (response.statusCode == 200) {
//       final schedules = jsonDecode(response.body) as List;
//       return schedules.map((c) => Schedule.fromJson(c)).toList();
//     } else {
//       throw Exception("Could not fetch schedules");
//     }
//   }

//   // Future<Schedule> update(int id, Schedule schedule) async {
//   //   final response = await http.put(Uri.parse("$_baseUrl/$id"),
//   //       headers: <String, String>{"Content-Type": "application/json"},
//   //       body: jsonEncode({
//   //         "id": schedule.id,
//   //         "vehicle_id": schedule.vehicleId,
//   //         "driver_id": schedule.driverId,
//   //         "manager_id": schedule.managerId,
//   //         "start": schedule.start,
//   //         "end": schedule.end
//   //       }));

//   //   if (response.statusCode == 200) {
//   //     return Schedule.fromJson(jsonDecode(response.body));
//   //   } else {
//   //     throw Exception("Could not update the schedule");
//   //   }
//   // }

//   // Future<void> delete(int id) async {
//   //   final response = await http.delete(Uri.parse("$_baseUrl/$id"));
//   //   if (response.statusCode != 204) {
//   //     throw Exception("Field to delete the schedule");
//   //   }
//   // }
// }
