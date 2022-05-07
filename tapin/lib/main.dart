import 'package:firebase_core/firebase_core.dart';
import 'package:tapin/screens/DirectChat/DirectChatRoom.dart';
import 'package:tapin/screens/signup/localwidgets/passwordResetScreen.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import 'package:tapin/utils/OurTheme.dart';
import 'package:flutter/material.dart';

import 'screens/login/login.dart';
import 'screens/discover/discover.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
      //home:
      // OurLogin(),
      routes: {
        //'/': (context) => Feed(),
        '/': (context) => OurLogin(),
        //'/': (context) => chatRoom(),
        '/profileapp': (context) => ProfileApp(),
        '/userfeed': (context) => Feed(),
        '/resetpasswordscreen': (context) => OurPasswordResetScreen(),
        '/discover': (context) => Discover(),
      },
    );
  }
}
