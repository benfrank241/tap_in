import 'package:firebase_core/firebase_core.dart';
import 'package:tapin/constants.dart';
import 'package:tapin/screens/createpost/new_post_view.dart';
import 'package:tapin/screens/userchats/chatScreen.dart';
import 'package:tapin/screens/signup/localwidgets/passwordResetScreen.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import 'package:tapin/utils/OurTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//iimport 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tapin/widgets/tabbedwindow/UserSettingsTabbed.dart';

import 'screens/login/login.dart';
import 'screens/userdash/userdash.dart';
import 'screens/userlists/organizations.dart';
import 'screens/userlists/correspondences.dart';
import 'screens/userorganization/userorganization.dart';
import 'screens/userchats/chatScreen.dart';
import 'screens/discover/discover.dart';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:tapin/services/graphQLConf.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //get typenameDataIdFromObject => null; //look into actual fix
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
      //home:
      // OurLogin(),
      routes: {
        //'/': (context) => Feed(),
        '/': (context) => NewPostView(),
        //'/': (context) => OurLogin(),
        '/profileapp': (context) => ProfileApp(),
        '/userfeed': (context) => Feed(),
        '/usersettings': (context) => UserSettings(),
        '/userdash': (context) => UserDash(),
        '/userorganizations': (context) => UserOrganizationList(),
        '/usercorrespondences': (context) => UserCorrespondenceList(),
        '/userorganization': (context) => UserOrganization(),
        '/resetpasswordscreen': (context) => OurPasswordResetScreen(),
        '/discover': (context) => Discover(),
      },
    );
  }
}
