import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

enum AuthModes { login, signup }

class _AuthScreenState extends State<AuthScreen> {
  AuthModes _authMode = AuthModes.login;
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _username = "";
  bool _isChef = false;

  // for password field

  bool isNotPasswordVisible = true;

  // submit function
  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print(_email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            width: size.width * 0.85,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(45),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 4),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 60,
                  ),
                  Text(
                    'MyChef',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),

                  // email form field **
                  TextFormField(
                    validator: (value) => !value.contains('@') || value.isEmpty
                        ? 'email not valide'
                        : null,
                    onSaved: (value) => _email = value,
                    style: TextStyle(fontSize: 18),
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Colors.red)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),
                  // **
                  if (_authMode == AuthModes.signup) SizedBox(height: 20),
                  if (_authMode == AuthModes.signup)
                    TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'please enter your Username' : null,
                      onSaved: (value) => _username = value,
                      style: TextStyle(fontSize: 18),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.red)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'User name',
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),

                  SizedBox(height: 20.0),
                  // password form field **
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      TextFormField(
                        validator: (value) => value.isEmpty
                            ? 'password not valide / password should be at least 6 caracters'
                            : null,
                        onSaved: (value) => _password = value,
                        style: TextStyle(fontSize: 18),
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        obscureText: isNotPasswordVisible,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Colors.red)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                      ),
                      Positioned(
                        right: 8.0,
                        child: IconButton(
                          icon: isNotPasswordVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                          onPressed: () => setState(() =>
                              isNotPasswordVisible = !isNotPasswordVisible),
                        ),
                      ),
                    ],
                  ),
                  // **
                  SizedBox(height: 20.0),
                  if (_authMode == AuthModes.signup)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isChef ? 'I am a Chef' : 'I am a Client',
                          style: TextStyle(fontSize: 15),
                        ),
                        Switch(
                            value: _isChef,
                            onChanged: (value) {
                              setState(() {
                                _isChef = value;
                              });
                            }),
                      ],
                    ),
                  ElevatedButton(
                    child: Text(
                      _authMode == AuthModes.login ? 'Sign in' : 'Register',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    style:
                        ButtonStyle(elevation: MaterialStateProperty.all(0.0)),
                    onPressed: _submit,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _authMode = (_authMode == AuthModes.login)
                              ? AuthModes.signup
                              : AuthModes.login;
                        });
                        Provider.of<Auth>(context, listen: false).testApi();
                      },
                      child: Text(
                        _authMode == AuthModes.login
                            ? 'i don\'t have an account'
                            : 'i have an account',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
