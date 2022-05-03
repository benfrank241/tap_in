import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tapin/utils/ourTheme.dart';
import '../signup/signup.dart';

void feed2() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {

        if(snapshot.hasError) {
          //return SomethingWrong():
        }
        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: OurTheme().buildTheme(),
            home: OurSignup(),
          );
        }
        return Text("Loading");
      }
    );
  }
}

