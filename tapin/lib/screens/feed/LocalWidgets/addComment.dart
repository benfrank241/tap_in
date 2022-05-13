import 'package:flutter/material.dart';
import 'package:tapin/services/post.dart';
import 'package:tapin/wrapper/Wrapper.dart';

class addComment extends StatefulWidget {
  final String id;

  addComment(this.id);

  @override
  _addCommentState createState() => _addCommentState();
}

class _addCommentState extends State<addComment> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Comment'), actions: <Widget>[
          FlatButton(
              textColor: Colors.white,
              onPressed: () async {
                Wrapper().addComment(text, widget.id);
                Navigator.pop(context);
              },
              child: Text('Post'))
        ]),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: new Form(child: TextFormField(onChanged: (val) {
              setState(() {
                text = val;
              });
            }))));
  }
}
