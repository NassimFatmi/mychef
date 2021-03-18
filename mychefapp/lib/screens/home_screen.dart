import 'package:flutter/material.dart';
import 'package:mychefapp/services/auth.dart';
import 'package:provider/provider.dart';

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
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Provider.of<Auth>(context, listen: false).logOut();
                  })
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
            ),
          ),
        ],
      ),
    );
  }
}
