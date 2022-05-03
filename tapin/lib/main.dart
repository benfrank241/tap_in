import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tapin/screens/login/login.dart';
import 'package:tapin/screens/signup/signup.dart';
import 'package:tapin/screens/wrapper.dart';
import 'package:tapin/services/auth.dart';
import 'package:tapin/utils/ourTheme.dart';

import 'model/user_model.dart';
//import '../signup/signup.dart';

void main() {
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
            // return StreamProvider<UserModel>.value(
            //     value: AuthService().user,
            //     child: MaterialApp(
            //     home: Wrapper()),
            // );
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: OurTheme().buildTheme(),
              home: OurLogin(),
            );
          }
          return Text("Loading");
        }
    );
  }
}

