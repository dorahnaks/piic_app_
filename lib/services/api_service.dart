// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ApiService {
//   static const String baseUrl = 'https://your-django-api.com/api';
  
//   static Future<Map<String, dynamic>> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/auth/login/'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'email': email,
//         'password': password,
//       }),
//     );
    
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Login failed');
//     }
//   }
// }