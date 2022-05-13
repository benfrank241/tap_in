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
                    return CommentPostTile(
                        comment: thismodel['comment'],
                        createdBy: thismodel['createdBy']);
                  })
              : Container();
        },
      ),
    );
  }

  Widget CommentPostTile({required String comment, required String createdBy}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: [
        Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 37, 237, 160),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text('${createdBy.substring(0, 1).toUpperCase()} ')),
        SizedBox(
          width: 8,
        ),
        Text(comment, style: TextStyle(color: Colors.white)),
      ]),
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
                color: Colors.blue,
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
