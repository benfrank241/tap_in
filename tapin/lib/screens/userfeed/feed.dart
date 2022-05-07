import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/helper/helperfunctions.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/DirectChat/DirectChatRoom.dart';
import 'package:tapin/screens/discover/discover.dart';
import 'package:tapin/screens/userfeed/swipe.dart';
import 'package:flutter/material.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import '../groupchat/chatMain.dart';
import '../groupchat/homePage.dart';
import '../posts/add.dart';
import '../userprofile/profile.dart';
import '../posts/add.dart';

void main() => runApp(new Feed());

class Feed extends StatelessWidget {
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
    Tinder(),
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
      drawer: Drawer(),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: null,
      //   backgroundColor: Color.fromARGB(255, 37, 26, 26),
      //   onPressed: () {
      //     Navigator.of(context)
      //         .push(MaterialPageRoute(builder: (context) => Add()));
      //   },
      //   child: Icon(Icons.add),
      // ),
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
            icon: Icon(Icons.search),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Discover',
          ),
        ],
      ),
    );
  }
}
