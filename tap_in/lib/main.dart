import 'package:tap_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:swipe/swipe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = kParseApplicationId;
  final keyClientKey = kParseClientKey;
  final keyParseServerUrl = kUrl;

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  var firstObject = ParseObject('FirstClass')
    ..set('message',
        'Hey ! First message from Flutter. Parse is now connected burt');
  await firstObject.save();

  print('done');

  runApp(const MyApp());
}
int _selectedIndex = 0;


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),


        body: Swipe(
          child: Center(
            child : _pages.elementAt(_selectedIndex),
          ),
          onSwipeRight: () {
            setState(() {
              _onItemTapped(_selectedIndex+1);
            });
          },
          onSwipeLeft: () {
            setState(() {
              _onItemTapped(_selectedIndex-1);
            });
          },
        ),//New


        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blue,
          //fixedColor: Colors.white,
          elevation: 0,
          selectedFontSize: 20,
          selectedIconTheme: IconThemeData(color: Colors.white, size: 40),
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',

            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

