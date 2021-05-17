import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scapps_student/models/login_model.dart';
import 'package:scapps_student/models/logout_model.dart';
import 'package:scapps_student/models/student_user_model.dart';
import 'package:scapps_student/models/teacher_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = 'https://scapp-dev.koding.co.id';

class AuthService {
  // Login
  Future loginStudent(String _email, String _password) async {
    final loginUrl = "$baseUrl/api/v1/mobile/authentication/login";

    try {
      var response = await http.post(Uri.parse(loginUrl),
          body: {'email': _email, 'password': _password});

      var jsonResponse = json.decode(response.body);
      return LoginModel.fromJson(jsonResponse);
    } catch (e) {
      return e;
    }
  }

  // Logout
  Future logoutStudent(String token) async {
    final logoutUrl = '$baseUrl/api/v1/mobile/authentication/logout';

    try {
      var response = await http.get(Uri.parse(logoutUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var responseBody = json.decode(response.body);
      return LogoutModel.fromJson(responseBody);
    } catch (e) {
      return e;
    }
  }

  // Get Student User Profile
  Future getStudentProfile(String token) async {
    final url = '$baseUrl/api/v1/mobile/profile/detail';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var responseBody = json.decode(response.body);
      print("Get student profile success");
      return StudentUserModel.fromJson(responseBody);
    } catch (e) {
      return e;
    }
  }

  // Get Teacher User Profile
  Future getTeacherProfile(String token) async {
    final url = '$baseUrl/api/v1/mobile/profile/detail';

    try {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var responseBody = json.decode(response.body);
      return TeacherUserModel.fromJson(responseBody);
    } catch (e) {
      return e;
    }
  }

  // Check Token
  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String token = local.getString("token") ?? null;
    if (token != null) return token;
    return null;
  }

  // Check Role
  Future hasRole() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String role = local.getString("role") ?? null;
    if (role != null) return role;
    return null;
  }

  // Save the token and role using SharedPreference
  Future setLocalTokenAndRole(String token, String role) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token", token);
    local.setString("role", role);
  }

  Future unsetAll() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.clear();
    print("Cleared!");
  }

  // Force logout when token expired
}
