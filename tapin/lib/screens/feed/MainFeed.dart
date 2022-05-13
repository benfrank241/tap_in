import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/DirectChat/LocalWidgets/Conversation_screen.dart';
import 'package:tapin/wrapper/Wrapper.dart';

import '../../helper/helperfunctions.dart';
import '../../model/chat_model.dart';
import '../posts/add.dart';
import 'LocalWidgets/Comments.dart';

class MainFeed extends StatefulWidget {
  @override
  _MainFeed createState() => _MainFeed();
}

class _MainFeed extends State<MainFeed> {
  Stream? PostsStream;

  @override
  void initState() {
    getposts();
    super.initState();
  }

  getposts() async {
    Wrapper().getAllPosts().then((val) {
      setState(() {
        PostsStream = val;
      });
    });
  }

  Widget AllPostList() {
    return Expanded(
      child: StreamBuilder(
        stream: PostsStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Map thismodel = snapshot.data.docs[index].data();
                    return FeedPostTile(
                      creator: thismodel['username'],
                      text: thismodel['text'],
                      createdAt: thismodel['timestamp'].toDate().toString(),
                      likes: thismodel['likes'],
                      id: snapshot.data.docs[index].id,
                    );
                  })
              : Container();
        },
      ),
    );
  }

  Future<int> getLikes(id) async {
    int likes = -1;
    await Wrapper().getPostLikes(id).then((val) {
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

  Widget FeedPostTile(
      {required String creator,
      required String text,
      required String createdAt,
      required int likes,
      required String id}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@$creator - $createdAt',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141)),
                ),
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          ),

          //Spacer(),
          Column(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentScreen(
                            creator, text, createdAt, likes, id)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 37, 237, 160),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Tap In'),
              ),
            ),
            GestureDetector(
              onTap: () {
                addLike(id, likes);
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
            Text('$likes'),
          ]),
        ],
      ),
    );
  }

  addLike(id, likes) async {
    await Wrapper().addPostLike(id, likes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: Container(
        child: Container(
          child: Column(
            children: [
              AllPostList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Color.fromARGB(255, 255, 183, 255),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Add()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
