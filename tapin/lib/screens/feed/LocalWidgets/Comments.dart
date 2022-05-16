import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../wrapper/Wrapper.dart';

class CommentScreen extends StatefulWidget {
  final String creator;
  final String text;
  final String createdAt;
  final String id;
  CommentScreen(this.creator, this.text, this.createdAt, this.id);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  Stream? CommentsStream;
  TextEditingController commentText = TextEditingController();

  int likes = -1;

  @override
  void initState() {
    getlikes();
    getComments();
    super.initState();
  }

  getComments() async {
    await Wrapper().getAllComments(widget.id).then((val) {
      setState(() {
        CommentsStream = val;
      });
    });
  }

  getlikes() async {
    await Wrapper().getPostLikes(widget.id).then((val) {
      setState(() {
        Map thismodel = val.data();
        likes = thismodel['likes'];
      });
    });
  }

  addLike() async {
    await Wrapper().addPostLike(widget.id, likes);
    setState(() {
      getlikes();
    });
  }

  Widget allCommentsList() {
    return Expanded(
      child: StreamBuilder(
        stream: CommentsStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Map thismodel = snapshot.data.docs[index].data();
                    if (thismodel['timestamp'] == null) {
                      return Container();
                    }
                    return CommentPostTile(
                      comment: thismodel['comment'],
                      createdBy: thismodel['createdBy'],
                      createdAt: thismodel['timestamp']
                          .toDate()
                          .toString()
                      .substring(5,16),
                    );
                  })
              : Container();
        },
      ),
    );
  }

  Widget CommentPostTile(
      {required String comment,
      required String createdBy,
      required createdAt}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@$createdBy',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141), fontSize: 16),
                ),
                Text(
                  comment,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          Text(
            '$createdAt',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Color.fromARGB(255, 148, 144, 141), fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget MainPost() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.creator}',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141), fontSize: 18),
                ),
                Text(
                  widget.text,
                  // maxLines: 3,
                  // overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 19),
                ),
                Text(
                  '${widget.createdAt.substring(0, 11)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141), fontSize: 15),
                ),
              ],
            ),
          ),
          Column(children: [
            GestureDetector(
              onTap: () {
                addLike();
              },
              child: Container(
                  height: 40,
                  width: 40,
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //         colors: [
                  //           Color.fromARGB(54, 255, 255, 255),
                  //           Color.fromARGB(255, 255, 255, 255)
                  //         ],
                  //         begin: FractionalOffset.topLeft,
                  //         end: FractionalOffset.bottomRight),
                  //     borderRadius: BorderRadius.circular(40)),
                  //padding: EdgeInsets.all(12),
                  child: Image.asset(
                    "assets/images/fire.png",
                    height: 25,
                    width: 25,
                  )),
            ),
            //Text('${getLikes(widget.id)}'),
            Text(
              '${likes}',
              style: TextStyle(color: Colors.white),
            ),
          ]),
        ]));
  }

  addCommentPopUp(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Comment:'),
            content: TextField(
              controller: commentText,
              //decoration: InputDecoration(hintText: "Add Post"),
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
                  if (commentText.text == '') {
                    Fluttertoast.showToast(msg: 'Please enter some text');
                  } else {
                    Wrapper().addComment(commentText.text, widget.id);
                    Fluttertoast.showToast(msg: 'Posted');
                    commentText.clear();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Container(
          child: Column(
            children: [
              MainPost(),
              Divider(
                height: 1,
                thickness: 1,
                color: Color.fromARGB(200, 96, 94, 92),
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Comments',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
              allCommentsList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Color.fromARGB(255, 255, 183, 255),
        onPressed: () {
          addCommentPopUp(context);
        },
        child: Icon(
          Icons.message_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
