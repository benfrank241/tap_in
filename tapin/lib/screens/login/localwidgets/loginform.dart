import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tapin/helper/helperfunctions.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/mainrouter/mainrouter.dart';
import 'package:tapin/screens/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  bool isChecked = false;
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController displayName = TextEditingController();

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
            style: TextStyle(fontSize: 20.0, color: Colors.white),
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
              prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
              hintText: "email",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
          TextFormField(
            controller: password,
            obscureText: true,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
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
              prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
              hintText: "password",
              hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
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
            padding: EdgeInsets.symmetric(vertical: 1),
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
                        Fluttertoast.showToast(msg: 'To be implemented');
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
            height: 50.0,
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
              primary: Theme.of(context).primaryColorDark,
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
              primary: Theme.of(context).primaryColorDark,
              shape: StadiumBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton.icon(
            onPressed: () {
              GoogleLogin();
            },
            //icon: ImageIcon(AssetImage('assets/images/google_logo.png')),
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text("Sign in with Google"),
            style: ElevatedButton.styleFrom(),
          )

          // TextButton(
          //     child: Text(
          //       'forgot password',
          //       style: TextStyle(
          //         color: Theme.of(context).primaryColor,
          //         fontSize: 14,
          //         decoration: TextDecoration.underline,
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/resetpasswordscreen');
          //     }),
        ],
      ),
    ));
  }

  void SignIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        //if email is not a email maybe its username right? RIGHT????
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email)) {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('users')
              .where('username', isEqualTo: email)
              .get();
          if (snap.docs.isEmpty) {
            Fluttertoast.showToast(msg: 'Invalid Username/Email!');
            return;
          }
          displayName.text = email;
          email = snap.docs[0]['email'];
        }
        HelperFunctions.saveUserEmailSharedPreference(email);
        if (displayName.text == '') {
          QuerySnapshot snap = await FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: email)
              .get();
          displayName.text = snap.docs[0]['username'];
        }
        HelperFunctions.saveUserNameSharedPreference(displayName.text);
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  HelperFunctions.saveUserLoggedInSharedPreference(true),
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => mainRouter())),
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

  Future GoogleLogin() async {
    final googleSignIn = GoogleSignIn();

    GoogleSignInAccount? _user;

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    _user = googleUser;

    final _googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: _googleAuth.accessToken,
      idToken: _googleAuth.idToken,
    );

    User? user =
        (await FirebaseAuth.instance.signInWithCredential(credential)).user;

    if (user != null) {
      UserModel userModel = UserModel();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get()
          .then((value) => {
                if (value.exists)
                  {
                    displayName.text = value.data()!['username'],
                    print(displayName.text),
                    HelperFunctions.saveUserNameSharedPreference(
                        displayName.text),
                    Fluttertoast.showToast(msg: "Login Successful"),
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => mainRouter())),
                  }
                else
                  {
                    print('wassup bro'),
                    {_displayNamePopUp(context)},
                  }
              });
    }
  }

  postDetailsToFirestore() async {
    //calling firestore

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    //caling usermodel

    UserModel usermodel = UserModel();

    //sending values

    usermodel.email = user!.email;
    usermodel.uid = user.uid;
    usermodel.username = displayName.text.trim();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(usermodel.tomap());

    HelperFunctions.saveUserNameSharedPreference(displayName.text);
    Fluttertoast.showToast(msg: "Login Successful");
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => mainRouter()));
  }

  Future<void> _displayNamePopUp(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('First Time User:'),
          content: TextField(
            controller: displayName,
            decoration: InputDecoration(hintText: "Enter a displayName"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isEqualTo: displayName.text)
                    .get()
                    .then((value) => {
                          if (value.docs.isEmpty)
                            {
                              postDetailsToFirestore(),
                            }
                          else
                            {
                              Fluttertoast.showToast(
                                  msg: 'Username is already taken.'),
                              displayName.text = '',
                            }
                        });
              },
            ),
          ],
        );
      },
    );
  }
}
