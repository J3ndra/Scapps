import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scapps_student/models/login_model.dart';
import 'package:scapps_student/models/logout_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = 'https://scapp-dev.koding.co.id';

class AuthService {
  // Login
  Future loginStudent(String _email, String _password) async {
    final loginUrl = "$baseUrl/api/v1/student/authentication/login";

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
    final logoutUrl = '$baseUrl/api/v1/student/authentication/logout';

    try {
      var response = await http.post(Uri.parse(logoutUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      });

      var responseBody = json.decode(response.body);
      return LogoutModel.fromJson(responseBody);
    } catch (e) {
      return e;
    }
  }

  // Save the token using SharedPreference
  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final String token = local.getString("token") ?? null;
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token", token);
  }

  Future unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token", null);
  }

  // Force logout when token expired
}
