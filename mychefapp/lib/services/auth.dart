import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<void> testApi() async {
    var apiURl = Uri.http('root@192.168.43.87:8000', '/api/test');
    var response = await http.get(apiURl);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      print(result['name']);
    }
  }

  Future<void> _authentificate(String email, String password) async {
    final url = Uri.http('', '');

    http.Response response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      // succeful request

    } else {}
  }
}
