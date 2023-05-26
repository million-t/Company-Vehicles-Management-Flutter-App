import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data_providers/remote_user_data_provider.dart';
import '../models/userModel.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final UserDataProvider dataProvider = UserDataProvider();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString('token');

    return value;
  }

  Future logout() async {
    dataProvider.logout();
    return;
  }

  // Future<String?> getType() async {
  //   String? type = await storage.read(key: 'type');
  //   return type;
  // }

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    return user;
  }

  Future<User> signup(User user) async {
    return dataProvider.signup(user);
  }

  Future<User> login(String email, String password) async {
    return dataProvider.login(email, password);
  }

  // Future<User> update(int id, User report) async {
  //   return dataProvider.update(id, report);
  // }

  // Future<List<User>> getAllToManager(String token) async {
  //   return dataProvider.getAllToManager(token);
  // }

  // Future<List<User>> getAllByDriver(String token) async {
  //   return dataProvider.getAllByDriver(token);
  // }

  // Future<void> delete(int id) async {
  //   dataProvider.delete(id);
  // }
}
