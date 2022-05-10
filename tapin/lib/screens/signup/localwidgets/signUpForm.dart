import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/helper/helperfunctions.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:tapin/screens/userfeed/feed.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  //firebase
  final _auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController displayName = TextEditingController();
  bool flag = false;
  bool isEnabled = false;
  final _formKey = GlobalKey<FormState>();

  String? errorMessage;

  @override
  void initState() {
    displayName = TextEditingController();
    password = TextEditingController();
    email = TextEditingController();
    super.initState();
    bool flag = false;
    bool isEnabled = false;

    // displayName.addListener(() {
    //   setState(() {
    //     isEnabled = displayName.text.isNotEmpty;
    //   });
    // });

    // email.addListener(() {
    //   setState(() {
    //     isEnabled = email.text.isNotEmpty;
    //   });
    // });

    // password.addListener(() {
    //   setState(() {
    //     isEnabled = password.text.isNotEmpty;
    //   });
    // });

    // confirmPassword.addListener(() {
    //   setState(() {
    //     isEnabled = confirmPassword.text.isNotEmpty;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 8.0),
          ),
          TextFormField(
            controller: displayName,
            onChanged: (text) {
              setState(() {});
              validateButton();
            },
            style: TextStyle(fontSize: 18.0),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person,
                  color: const Color.fromARGB(255, 96, 94, 92)),
              hintText: "display name",
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 148, 144, 141)),
            ),
          ),
          TextFormField(
            controller: email,
            onChanged: (text) {
              setState(() {});
              validateButton();
            },
            style: TextStyle(fontSize: 18.0),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email,
                  color: const Color.fromARGB(255, 96, 94, 92)),
              hintText: "email",
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 148, 144, 141)),
            ),
          ),
          TextFormField(
            controller: password,
            onChanged: (text) {
              setState(() {});
              validateButton();
            },
            obscureText: true,
            style: TextStyle(fontSize: 18.0),
            //autovalidateMode: AutovalidateMode.onUserInteraction,
            // validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     setState(() {
            //       isEnabled = false;
            //     });
            //     print(isEnabled);
            //   } else {
            //     setState(() {
            //       isEnabled = false;
            //     });
            //     print(isEnabled);
            //   }
            // },
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline,
                  color: const Color.fromARGB(255, 96, 94, 92)),
              hintText: "password",
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 148, 144, 141)),
            ),
          ),
          TextFormField(
            controller: confirmPassword,
            onChanged: (text) {
              setState(() {});
              validateButton();
            },
            obscureText: true,
            style: TextStyle(fontSize: 18.0),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open,
                  color: const Color.fromARGB(255, 96, 94, 92)),
              hintText: "confirm password",
              hintStyle: TextStyle(
                  fontSize: 18.0, color: Color.fromARGB(255, 148, 144, 141)),
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12.5),
              child: Text(
                "signup",
                style: TextStyle(
                    color: Theme.of(context).unselectedWidgetColor,
                    fontSize: 18),
              ),
            ),
            onPressed: isEnabled
                ? () async {
                    _signup();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColorDark,
              shape: StadiumBorder(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          )
        ],
      ),
    );
  }

  void validateButton() {
    if (password.text == '' ||
        confirmPassword.text == '' ||
        displayName.text == '' ||
        email.text == '') {
      isEnabled = false;
    } else {
      isEnabled = true;
    }
    // if (displayName.text == '')
    //   isEnabled = false;
    // else
    //   isEnabled = true;
  }

  void _signup() async {
    //ParseFileBase? parseFile2;
    /* var multipartFile2 = http.MultipartFile.fromBytes(
                          'file',
                          (await rootBundle.load(
                              '')).buffer.asUint8List(),
                          contentType: http_parser.MediaType('image', 'jpg')
                      ); */
    //parseFile2 = ParseFile(File("path"));

    //check if duplicate username

    bool dupliflag = false;

    await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: displayName.text)
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty) dupliflag = true,
            });

    bool emailvalid = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(email.text);
    if (password.text == '' ||
        confirmPassword.text == '' ||
        displayName.text == '' ||
        email.text == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Something is empty')));
    } else if (!emailvalid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter a valid email')));
    } else if (dupliflag) {
      displayName.text = '';
      Fluttertoast.showToast(msg: 'Display Name has already been taken');
    } else if (password.text == confirmPassword.text) {
      try {
        //sharedPreferences
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserEmailSharedPreference(email.text.trim());
        HelperFunctions.saveUserNameSharedPreference(displayName.text.trim());

        await _auth
            .createUserWithEmailAndPassword(
              email: email.text.trim(),
              password: password.text.trim(),
            )
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match, please try again')));
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
    Fluttertoast.showToast(msg: 'Account Created Successfully!');

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => Feed()), (route) => false);
  }
}
