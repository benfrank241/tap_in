import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/helper/helperfunctions.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/DirectChat/DirectChatRoom.dart';
import 'package:tapin/screens/discover/discover.dart';
import 'package:flutter/material.dart';
import 'package:tapin/screens/feed/MainFeed.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import '../../widgets/tabbedwindow/UserSettingsTabbed.dart';
import '../feed/swipe.dart';
import '../groupchat/chatMain.dart';
import '../groupchat/homePage.dart';
import '../posts/add.dart';
import '../userprofile/profile.dart';
import '../posts/add.dart';

void main() => runApp(new mainRouter());

class mainRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 50, 50, 50),
        appBarTheme: AppBarTheme(
          color: const Color.fromARGB(255, 50, 50, 50),
        ),
      ),
      home: new Center(
        child: MyHomePage(title: ''),
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
  //firebase

  User? user = FirebaseAuth.instance.currentUser;
  UserModel LoggedInuser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.LoggedInuser = UserModel.fromMap(value.data());
      setState(() {
        //Constants.myName = LoggedInuser.username;
        getUserInfo();
      });
    });
    //getUserInfo();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
  }

  int currentIndex = 1;

  final screens = [
    //chatMain(),
    chatRoom(),
    MainFeed(),
    //Tinder(),
    Discover(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Container(
          width: 90,
          child: Image.asset('assets/images/icon.png'),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 40,
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfileApp()));
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserSettings()));
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Color.fromARGB(255, 50, 50, 50),
        selectedItemColor: Color.fromARGB(255, 255, 183, 255),
        unselectedItemColor: Colors.white,
        iconSize: 28,
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
