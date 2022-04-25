import 'package:tapin/screens/discover/discover.dart';
import 'package:tapin/screens/userfeed/swipe.dart';
import 'package:flutter/material.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import 'package:tapin/widgets/tabbedwindow/UserSettingsTabbed.dart';
import 'package:tapin/widgets/NavBar.dart';
import '../groupchat/chatMain.dart';
import '../groupchat/homePage.dart';
import '../userprofile/profile.dart';

void main() => runApp(new Feed());

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
     home: new Center(
        child: MyHomePage(title: 'tap-in'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 1;

  final screens = [
    chatMain(),
    Tinder(),
    Discover(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text(widget.title),
        actions: <Widget>[
        TextButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProfileApp())
          );
        },
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.greenAccent[400],
            radius: 100,
            backgroundImage: NetworkImage('assets/images/beesechurger.jpg'),
            child: Text(
              'profile',
              style: TextStyle(fontSize: 10, color: Colors.white),
                 ), //Text
               ), //CircleAvatar
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: 20,
        selectedFontSize: 15,
        unselectedFontSize: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
        ],
      ),
    );
  }
}
