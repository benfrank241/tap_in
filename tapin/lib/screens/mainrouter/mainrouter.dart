import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/helper/helperfunctions.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/DirectChat/DirectChatRoom.dart';
import 'package:tapin/screens/discover/discover.dart';
import 'package:flutter/material.dart';
import 'package:tapin/screens/feed/MainFeed.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import '../../widgets/tabbedwindow/UserSettingsTabbed.dart';
import '../groupchat/chatMain.dart';
import '../groupchat/homePage.dart';
import '../userprofile/profile.dart';

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
    //Tinder(),
    chatRoom(),
    MainFeed(),
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
        backgroundColor: Color.fromARGB(255, 50, 50, 50),
        child: ListView(
          padding: EdgeInsets.only(top: 60),
          children: [
            const SizedBox(
              height: 130,
              child: DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo3.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Divider(
              height: 5,
              thickness: 5,
              color: Color.fromARGB(255, 37, 237, 160),
            ),
            ListTile(
              title: const Text('Settings',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UserSettings()));
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 96, 94, 92),
            ),
            ListTile(
              title: const Text('TBD',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              onTap: () {
                Fluttertoast.showToast(msg: 'To be implemented');
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 96, 94, 92),
            ),
            ListTile(
              title: const Text('TBD',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              onTap: () {
                Fluttertoast.showToast(msg: 'To be implemented');
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 96, 94, 92),
            ),
            ListTile(
              title: const Text('TBD',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              onTap: () {
                Fluttertoast.showToast(msg: 'To be implemented');
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 96, 94, 92),
            ),
            ListTile(
              title: const Text('TBD',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              onTap: () {
                Fluttertoast.showToast(msg: 'To be implemented');
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 96, 94, 92),
            ),
            ListTile(
              title: const Text('TBD',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  )),
              onTap: () {
                Fluttertoast.showToast(msg: 'To be implemented');
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 96, 94, 92),
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
