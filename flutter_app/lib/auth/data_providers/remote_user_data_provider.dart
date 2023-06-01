import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../util/serverIp.dart';
import '../models/userModel.dart';

class UserDataProvider {
  static final String _baseUrl = "${Server().ip}/user";

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // await prefs.remove(key: 'type');
    // await prefs.remove(key: 'user');
  }

  Future<User> login(String email, String password) async {
    final http.Response response = await http.post(Uri.parse("$_baseUrl/login"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }));
    print('login check 0');

    if (response.statusCode == 200) {
      print('login check 1');
      final prefs = await SharedPreferences.getInstance();
      print('login check 2');

      String token = jsonDecode(response.body)["token"];
      await prefs.setString('token', 'token $token');
      await prefs.setString('user', response.body);
      print('login check 3');

      return User.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Login failed.");
    }
  }

  Future<User> signup(User user) async {
    final http.Response response =
        await http.post(Uri.parse("$_baseUrl/signup"),
            headers: <String, String>{"Content-Type": "application/json"},
            body: jsonEncode({
              "name": user.name,
              "email": user.email,
              "password": user.password,
              "type": user.type,
              "manager_id": user.managerId
            }));

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();

      String token = jsonDecode(response.body)["token"];
      prefs.setString('token', 'token $token');
      prefs.setString('user', response.body);

      return User.fromJson(jsonDecode(response.body));
    }
    {
      throw Exception("Signup failed.");
    }
  }

  Future<User> getUser() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Couldn't fetch user.");
    }
  }

  Future<List<User>> fetchAll(String token) async {
    final response = await http.get(
      Uri.parse("$_baseUrl/drivers"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": token
      },
    );
    if (response.statusCode == 200) {
      final drivers = jsonDecode(response.body) as List;
      return drivers.map((c) => User.fromJson(c)).toList();
    } else {
      throw Exception("Could not fetch courses");
    }
  }

  Future<User> update(int id, User course) async {
    final response = await http.put(Uri.parse("$_baseUrl/$id"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "_id": id,
        }));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Could not update the course");
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse("$_baseUrl/$id"));
    if (response.statusCode != 204) {
      throw Exception("Field to delete the course");
    }
  }
}
