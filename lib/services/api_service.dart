import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator localhost
  // Use your local IP (e.g., 192.168.1.100) for real device testing
  static const String baseUrl = 'http://localhost:8000/api';

  // --- AUTHENTICATION ---
  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/token/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access']);
        await prefs.setString('refresh_token', data['refresh']);
        return true;
      }
      return false;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // --- HELPERS ---
  Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // --- DATA FETCHING ---
  
  Future<Map<String, dynamic>?> getProfile() async {
    final token = await getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/members/members/');
    try {
      final response = await http.get(url, headers: _headers(token));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) return data[0]; 
      }
    } catch (e) {
      print('Profile Error: $e');
    }
    return null;
  }

  Future<List<dynamic>> getContributions() async {
    final token = await getToken();
    if (token == null) return [];

    final url = Uri.parse('$baseUrl/contributions/contributions/');
    try {
      final response = await http.get(url, headers: _headers(token));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Contributions Error: $e');
    }
    return [];
  }
  
  Future<List<dynamic>> getClusters() async {
    final token = await getToken();
    if (token == null) return [];

    final url = Uri.parse('$baseUrl/clusters/clusters/');
    try {
      final response = await http.get(url, headers: _headers(token));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print('Clusters Error: $e');
    }
    return [];
  }
}