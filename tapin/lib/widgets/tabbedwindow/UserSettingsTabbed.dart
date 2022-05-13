import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'dart:math';

Future main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());

  runApp(UserSettings());
}

class UserSettings extends StatefulWidget {
  static final String title = 'Settings';
  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';

  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext) => Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Container(
              width: 97,
              height: 24,
              child: Stack(children: <Widget>[
                Positioned(
                    child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(),
                        child: Stack(children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Color.fromARGB(255, 255, 183, 255),
                          ),
                        ]))),
                Positioned(
                    top: 3,
                    left: 27,
                    child: Text(
                      'Settings',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Comfortaa',
                          fontSize: 16,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1),
                    )),
              ]))),
      body: Container(
          child: Stack(children: <Widget>[
        Positioned(
            top: 70,
            left: 65,
            child: Text(
              'Account',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.bold,
                  height: 1),
            )),
        Positioned(
            top: 120,
            left: 39,
            child: SizedBox(
              height: 10.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.red,
                ),
              ),
            )
            //)
            ),
        Positioned(
            top: 100,
            left: 39,
            child: Text(
              'Username',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
        Positioned(
            top: 180,
            left: 39,
            child: Text(
              'Profile picture',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
        Positioned(
            top: 140,
            left: 39,
            child: Text(
              'Password',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
        Positioned(
            top: 84,
            left: 112,
            child: Container(
                width: 24,
                height: 24,
                child: Stack(children: <Widget>[
                  IconButton(
                    iconSize: 33,
                    icon: Icon(Icons.arrow_drop_down),
                    color: Color.fromARGB(255, 255, 183, 255),
                    onPressed: () {
                      //username
                    },
                  ),
                ]))),
        Positioned(
            top: 124,
            left: 112,
            child: Container(
                width: 24,
                height: 24,
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(children: <Widget>[
                            IconButton(
                              iconSize: 33,
                              icon: Icon(Icons.arrow_drop_down),
                              color: Color.fromARGB(255, 255, 183, 255),
                              onPressed: () {
                                //dead code
                              },
                            ),
                          ]))),
                ]))),
        Positioned(
            top: 165,
            left: 133,
            child: Container(
                width: 24,
                height: 24,
                child: Stack(children: <Widget>[
                  IconButton(
                    iconSize: 33,
                    icon: Icon(Icons.arrow_drop_down),
                    color: Color.fromARGB(255, 255, 183, 255),
                    onPressed: () {
                      //profile picture
                    },
                  ),
                ]))),
        Positioned(
            top: 205,
            left: 88,
            child: Container(
                width: 24,
                height: 24,
                child: Stack(children: <Widget>[
                  IconButton(
                    iconSize: 33,
                    icon: Icon(Icons.arrow_drop_down),
                    color: Color.fromARGB(255, 255, 183, 255),
                    onPressed: () {
                      //banner
                    },
                  ),
                ]))),
        Positioned(
            top: 245,
            left: 187,
            child: Container(
                width: 24,
                height: 24,
                child: Stack(children: <Widget>[
                  IconButton(
                    iconSize: 33,
                    icon: Icon(Icons.arrow_drop_down),
                    color: Color.fromARGB(255, 255, 183, 255),
                    onPressed: () {
                      //personal information
                    },
                  ),
                ]))),
        Positioned(
            top: 24,
            left: 76,
            child: Container(
                width: 263,
                height: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: Color.fromRGBO(124, 123, 123, 1),
                ))),
        Positioned(
            top: 21,
            left: 83,
            child: Container(
              width: 24,
              height: 24,
              child: IconButton(
                iconSize: 22,
                icon: Icon(Icons.search),
                color: Color.fromARGB(255, 50, 50, 50),
                onPressed: () {
                  //search
                },
              ),
            )),
        Positioned(
            top: 30,
            left: 118,
            child: Text(
              'Search...',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
        Positioned(
            top: 300,
            left: 29,
            child: Container(
                width: 331.9999694824219,
                height: 505,
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 0,
                      left: 36,
                      child: Text(
                        'Preferences',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      )),
                  Positioned(
                      top: 0,
                      left: 10,
                      child: Transform.rotate(
                        angle: 1.3293460656354311e-8 * (pi / 180),
                        child: Divider(
                            color: Color.fromRGBO(36, 239, 173, 1),
                            thickness: 1),
                      )),
                  Positioned(
                      top: 19,
                      left: 10,
                      child: Transform.rotate(
                        angle: 1.3293460656354311e-8 * (pi / 180),
                        child: Divider(
                            color: Color.fromRGBO(36, 239, 173, 1),
                            thickness: 1),
                      )),
                  Positioned(
                      top: 13,
                      left: 97,
                      child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(children: <Widget>[
                            IconButton(
                              iconSize: 33,
                              icon: Icon(Icons.arrow_drop_down),
                              color: Color.fromARGB(255, 255, 183, 255),
                              onPressed: () {
                                //notifications
                              },
                            ),
                          ]))),
                  Positioned(
                      top: 53,
                      left: 68,
                      child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(children: <Widget>[
                            IconButton(
                              iconSize: 33,
                              icon: Icon(Icons.arrow_drop_down),
                              color: Color.fromARGB(255, 255, 183, 255),
                              onPressed: () {
                                //location
                              },
                            ),
                          ]))),
                  Positioned(
                      top: 134,
                      left: 100,
                      child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(children: <Widget>[
                            IconButton(
                              iconSize: 33,
                              icon: Icon(Icons.arrow_drop_down),
                              color: Color.fromARGB(255, 255, 183, 255),
                              onPressed: () {
                                //privacy policy
                              },
                            ),
                          ]))),
                  Positioned(
                      top: 174,
                      left: 120,
                      child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(children: <Widget>[
                            IconButton(
                              iconSize: 33,
                              icon: Icon(Icons.arrow_drop_down),
                              color: Color.fromARGB(255, 255, 183, 255),
                              onPressed: () {
                                //terms of service
                              },
                            ),
                          ]))),
                  Positioned(
                      top: 214,
                      left: 52,
                      child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(children: <Widget>[
                            IconButton(
                              iconSize: 33,
                              icon: Icon(Icons.arrow_drop_down),
                              color: Color.fromARGB(255, 255, 183, 255),
                              onPressed: () {
                                //logout
                              },
                            ),
                          ]))),
                  Positioned(
                      top: 30,
                      left: 10,
                      child: Text(
                        'Notifications',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Positioned(
                      top: 70,
                      left: 10,
                      child: Text(
                        'Location',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Positioned(
                      top: 110,
                      left: 27,
                      child: Text(
                        'More Options',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      )),
                  Positioned(
                      top: 363,
                      left: 2,
                      child: Transform.rotate(
                        angle: 8.735702467132093e-8 * (pi / 180),
                        child: Divider(
                            color: Color.fromRGBO(36, 239, 173, 1),
                            thickness: 1),
                      )),
                  Positioned(
                      top: 150,
                      left: 1,
                      child: Text(
                        'Privacy Policy ',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Positioned(
                      top: 190,
                      left: 1,
                      child: Text(
                        'Terms of Service',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  // Positioned(
                  //     top: 379,
                  //     left: 324,
                  //     child: Transform.rotate(
                  //       angle: -180 * (pi / 180),
                  //       child: Image.asset(
                  //         'assets/images/vector.svg',
                  //       ),
                  //     )),
                  // Positioned(
                  //     top: 416,
                  //     left: 324,
                  //     child: Transform.rotate(
                  //       angle: -180 * (pi / 180),
                  //       child: Image.asset(
                  //         'assets/images/vector.svg',
                  //       ),
                  //     )),
                  Positioned(
                      top: 230,
                      left: 1,
                      child: Text(
                        'Log out',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                  Positioned(
                      top: 270,
                      left: 0,
                      child: Text(
                        'Delete account',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromRGBO(255, 71, 71, 1),
                            fontFamily: 'Hind',
                            fontSize: 16,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1),
                      )),
                ]))),
        Positioned(
            top: 220,
            left: 39,
            child: Text(
              'Banner',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
        Positioned(
            top: 260,
            left: 39,
            child: Text(
              'Personal Information',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontFamily: 'Hind',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                  height: 1),
            )),
      ])));
}
