import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/screens/signup/localwidgets/signUpForm.dart';
import 'package:flutter/material.dart';

class OurSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(25.0),
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/default.jpg'),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 22.0),
                      ),
                      radius: 50.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                    ),
                    RawMaterialButton(
                      fillColor: Color.fromARGB(255, 255, 183, 255),
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {
                        Fluttertoast.showToast(msg: 'To be implemented');
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                OurSignUpForm(),
              ],
            ), //ListView
          )
        ],
      ),
    );
  }
}
