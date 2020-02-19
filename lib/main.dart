import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'pages/search.dart';
import 'pages/notifications.dart';
import 'pages/create_post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaiWong',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [
    HomePage(),
    SearcgPage(),
    CreatePostPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(children: pages),
        bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: new TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.search),
                ),
                Tab(
                  icon: Icon(Icons.add),
                ),
                Tab(
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  icon: Icon(Icons.perm_identity),
                ),
              ],
              unselectedLabelColor: Colors.white,
              labelColor: Colors.orange,
              indicatorColor: Colors.orange,
            )),
      ),
    );
  }
}
