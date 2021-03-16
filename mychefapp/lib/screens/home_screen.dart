import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.restaurant_menu,
            ),
            SizedBox(width: 8.0),
            Text('MyChef'),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [],
      ),
    );
  }
}
