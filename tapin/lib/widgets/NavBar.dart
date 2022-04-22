import 'package:flutter/material.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import 'package:tapin/screens/discover/discover.dart';

// class NavBar extends StatefulWidget {
//   @override
//   NavBarState createState() => NavBarState();
// }

//class NavBarState extends State<NavBar> {
class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 1;

    void _onItemTapped(int index) {
      currentIndex = index;
      // setState(() {
      if (index == 0) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Discover()));
      }

      if (index == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Feed()));
      }

      if (index == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Discover()));
      }
      //}
      //);
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(index),
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
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
        ],
      ),
    );
  }
}
