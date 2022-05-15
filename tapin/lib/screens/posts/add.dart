import 'package:flutter/material.dart';
import 'package:tapin/services/post.dart';
import 'package:tapin/wrapper/Wrapper.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final PostService _postService = PostService();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Topic'),
        actions: <Widget>[
          FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Wrapper().savePost(text);
                Navigator.pop(context);
              },
              child: Text('Post')),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: new Form(
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    text = val;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset("assets/images/logo3.png"),
            ),
          ),
        ],
      ),
    );
  }
}
