import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: true,
            actions: [
              IconButton(icon: Icon(Icons.more_vert_outlined), onPressed: () {})
            ],
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
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 2,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
