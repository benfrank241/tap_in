import 'package:tapin/screens/login/localwidgets/loginform.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // SizedBox(
          //   height: 10.0,
          // ),
          Expanded(
            child: ListView(
              physics:
                  const NeverScrollableScrollPhysics(), //make login screen unscrollable
              padding: EdgeInsets.all(25.0),
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Image.asset("assets/images/logo3.png"),
                ),
                SizedBox(
                  height: 50.0,
                ),
                OurLoginForm(),
              ],
            ), //ListView
          )
        ],
      ),
    );
  }
}
