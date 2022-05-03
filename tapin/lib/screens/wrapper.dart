import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import 'login/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if(user == null) {
      //show auth system routes
      return OurLogin();
    }

    return Feed();

  }
}