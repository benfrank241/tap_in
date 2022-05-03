import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:tapin/screens/posts/list.dart';
import 'package:tapin/services/posts.dart';

void main() =>
    runApp(MaterialApp(
      home: ProfileApp(),
    ));

class ProfileApp extends StatefulWidget {
  ProfileApp({Key? key}) : super(key: key);

  @override
  _ProfileAppState createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  PostService _postService = PostService();

  Widget build(BuildContext context) {
    return StreamProvider.value(
        value:
        _postService.getPostsByUser(FirebaseAuth.instance.currentUser?.uid),
        initialData: [],
        child: Scaffold(
          body: Container(
            child: ListPosts(),
          )
        )
    );
  }

}