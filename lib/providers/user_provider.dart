import 'package:facultad/models/user.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class UserProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  // Future<void> saveUserToPreferences() async {
  //   if (_user != null) {
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('user', json.encode(_user!.toJson()));
  //   }
  // }

  // Future<void> loadUserFromPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userData = prefs.getString('user');
  //   if (userData != null) {
  //     _user = User.fromJson(json.decode(userData));
  //     notifyListeners();
  //   }
  // }
}
