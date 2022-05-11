import 'package:flutter/material.dart';
import 'package:tapin/screens/mainrouter/mainrouter.dart';

import '../userprofile/profile.dart';
import 'chatPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

int _selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => mainRouter()));
      }

      if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfileApp()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        selectedFontSize: 20,
        unselectedIconTheme:
            IconThemeData(color: Colors.purpleAccent[100], size: 30),
        unselectedItemColor: Colors.purpleAccent[100],
        selectedIconTheme:
            IconThemeData(color: Colors.purpleAccent[100], size: 40),
        selectedItemColor: Colors.purpleAccent[100],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
