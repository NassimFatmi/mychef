import 'package:flutter/material.dart';
import 'package:mychefapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';
import 'services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'MyChef',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFFFC532),
          backgroundColor: Color(0xFFFCFAF9),
          appBarTheme:
              AppBarTheme(elevation: 0.0, backgroundColor: Color(0xFFFCFAF9)),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.green)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0)),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => states.contains(MaterialState.disabled)
                    ? null
                    : Color(0xFFFFC532),
              ),
              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 15)),
              shape: MaterialStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          switchTheme: SwitchThemeData(
            trackColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.yellow
                    : Colors.grey[400]),
            thumbColor: MaterialStateProperty.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? Colors.yellow
                    : Colors.black),
          ),
        ),
        home: AuthScreen(),
      ),
    );
  }
}
