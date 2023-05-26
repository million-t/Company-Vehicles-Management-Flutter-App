// import 'dart:convert';

// import 'package:http/http.dart' as http;

// import '../models/course.dart';

// class CourseDataProvider {
//   static const String _baseUrl = "http://10.0.2.2:9191/api/v1/courses";

//   Future<Course> create(Course course) async {
//     final http.Response response = await http.post(Uri.parse(_baseUrl),
//         headers: <String, String>{"Content-Type": "application/json"},
//         body: jsonEncode({
//           "code": course.code,
//           "title": course.title,
//           "ects": course.ects,
//           "description": course.description
//         }));

//     if (response.statusCode == 201) {
//       return Course.fromJson(jsonDecode(response.body));
//     }
//     {
//       throw Exception("Failed to create course");
//     }
//   }

//   Future<Course> fetchByCode(String code) async {
//     final response = await http.get(Uri.parse("$_baseUrl/$code"));

//     if (response.statusCode == 200) {
//       return Course.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Fetching Course by code failed");
//     }
//   }

//   Future<List<Course>> fetchAll() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//     if (response.statusCode == 200) {
//       final courses = jsonDecode(response.body) as List;
//       return courses.map((c) => Course.fromJson(c)).toList();
//     } else {
//       throw Exception("Could not fetch courses");
//     }
//   }

//   Future<Course> update(int id, Course course) async {
//     final response = await http.put(Uri.parse("$_baseUrl/$id"),
//         headers: <String, String>{"Content-Type": "application/json"},
//         body: jsonEncode({
//           "id": id,
//           "code": course.code,
//           "title": course.title,
//           "ects": course.ects,
//           "description": course.description
//         }));

//     if (response.statusCode == 200) {
//       return Course.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception("Could not update the course");
//     }
//   }

//   Future<void> delete(int id) async {
//     final response = await http.delete(Uri.parse("$_baseUrl/$id"));
//     if (response.statusCode != 204) {
//       throw Exception("Field to delete the course");
//     }
//   }
// }
