import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool _isAuth = false;
  bool get isAuth => _isAuth;

  // create user account -------------
  Future<void> createUser(String email, String password, String name) async {
    final api_url = Uri.http('192.168.43.87:8000', '/api/user/create');
    try {
      var response = await http.post(
        api_url,
        body: {
          'email': email,
          'name': name,
          'password': password,
        },
      );
      if (response.statusCode == 201) {
        await login(email, password);
      }
    } catch (e) {
      throw e;
    }
  }
  //---------------------------------

  // login with email and password -----

  Future<void> login(String email, String password) async {
    final api_url = Uri.http('192.168.43.87:8000', '/api/user/login');

    try {
      var response = await http.post(api_url, body: {
        'email': email,
        'password': password,
        'device_name': await getDeviceInfo(),
      });

      if (response.statusCode == 200) {
        String token = response.body;

        await saveToken(token);

        _isAuth = true;

        notifyListeners();
      }

      print(response.statusCode);
      print(response.body);
    } catch (e) {
      throw e;
    }
  }

  //--------------------------------

  // get device info --------------

  Future<String> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  //-------------------------------

  // try auto login ----------------

  Future tryAutoLogin() async {
    var token = await getToken();
    if (token != null) {
      _isAuth = true;
    } else {
      _isAuth = false;
    }
    notifyListeners();
  }

  //-------------------------------

  // logout ------------------------

  logOut() async {
    _isAuth = false;
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  //--------------------------------

  // savetoken for autologin ------

  saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  //-------------------------------

  // get token for auto login ----

  Future getToken() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('token')) {
      return prefs.getString('token');
    }
    return null;
  }

  //------------------------------

}
