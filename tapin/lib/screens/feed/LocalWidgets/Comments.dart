import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../wrapper/Wrapper.dart';
import 'addComment.dart';

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

  int likes = -1;

  @override
  void initState() {
    getposts();
    getlikes();
    super.initState();
  }

  getposts() async {
    await Wrapper().getAllComments(widget.id).then((val) {
      setState(() {
        CommentsStream = val;
      });
    });
  }

  getlikes() async {
    print(widget.id);
    await Wrapper().getPostLikes(widget.id).then((val) {
      setState(() {
        Map thismodel = val.data();
        likes = thismodel['likes'];
      });
    });
    print('${likes} this is in getLIKES INITSTATE');
  }

  addLike() async {
    await Wrapper().addPostLike(widget.id, likes);
    setState(() {
      getlikes();
    });
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
                  '@${widget.creator} - ${widget.createdAt}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141)),
                ),
                Text(
                  widget.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
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
            Text('${likes}'),
          ]),
        ]));
  }

  int getLikes(id) {
    int likes = -1;
    Wrapper().getPostLikes(id).then((val) {
      Map thismodel = val.docs[0].data();
      if (thismodel.isEmpty) {
        print('fuck me');
      }
      ;
      likes = thismodel['likes'];
    });
    print('likes in getlikes function');
    print(likes);
    return likes;
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
              //AllPostList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Color.fromARGB(255, 255, 183, 255),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => addComment(widget.id)));
        },
        child: Icon(
          Icons.message_sharp,
          color: Colors.black,
        ),
      ),
    );
  }
}
