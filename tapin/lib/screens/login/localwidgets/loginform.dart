import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapin/screens/signup/signup.dart';
import 'package:tapin/screens/userdash/userdash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import 'package:tapin/services/graphQLConf.dart';
import "package:tapin/services/queryMutation.dart";
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image/image.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  final _formKey = GlobalKey<FormState>();
  QueryMutation addMutation = QueryMutation();
  TextEditingController email = TextEditingController();
  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();
  bool isChecked = false;
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();

  String? errorMessage;

  //FireBase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
          ),
          TextFormField(
            controller: username,
            style: TextStyle(fontSize: 18.0),
            validator: (value) {
              if (value!.isEmpty) {
                return ("Please Enter Your Email/Username");
              }
              // reg expression for email validation
              // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              //     .hasMatch(value)) {
              //   return ("Please Enter a valid email");
              // }
              return null;
            },
            onSaved: (value) {
              username.text = value!;
            },
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_outlined,
                  color: Theme.of(context).primaryColor),
              hintText: "email",
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Theme.of(context).primaryColor),
            ),
          ),
          TextFormField(
            controller: password,
            obscureText: true,
            style: TextStyle(fontSize: 18.0),
            cursorColor: Colors.grey,
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return ("Password is required for login");
              }
              if (!regex.hasMatch(value)) {
                return ("Enter Valid Password(Min. 6 Character)");
              }
            },
            onSaved: (value) {
              password.text = value!;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline,
                  color: Theme.of(context).primaryColor),
              hintText: "password",
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Theme.of(context).primaryColor),
            ),
          ),
          /*RadioListTile(
            value: 1,
            title: const Text('remember me'),
            groupValue: 1,
            onChanged: (value) {
            // setState(() { });
            },
            toggleable: true,
            controlAffinity: ListTileControlAffinity.platform,
          ),*/
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Checkbox(
                    checkColor: Theme.of(context).primaryColor,
                    value: isChecked,
                    shape: CircleBorder(),
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                ),
                Text(
                  'remember me',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          ElevatedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12.5),
              child: Text(
                "login",
                style: TextStyle(
                    color: Theme.of(context).canvasColor, fontSize: 18),
              ),
            ),
            onPressed: () async {
              SignIn(username.text.trim(), password.text.trim());
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: StadiumBorder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          ),
          ElevatedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12.5),
              child: Text(
                "register",
                style: TextStyle(
                    color: Theme.of(context).canvasColor, fontSize: 18),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OurSignup(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: StadiumBorder(),
            ),
          ),
          TextButton(
              child: Text(
                'forgot password',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/resetpasswordscreen');
              }),
        ],
      ),
    ));
  }

  void SignIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email)) {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: email)
              .get();
          if (snap.docs.isEmpty) {
            Fluttertoast.showToast(msg: 'Invalid Username/Email!');
            return;
          }
          email = snap.docs[0]['email'];
        }
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Feed())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}
