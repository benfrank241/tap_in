import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/DirectChat/LocalWidgets/Conversation_screen.dart';
import 'package:tapin/wrapper/Wrapper.dart';
import 'package:flutter/cupertino.dart';
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

  String FilterState = 'Newest';

  @override
  void initState() {
    getposts();
    super.initState();
  }

  getposts() async {
    if (FilterState == 'Newest') {
      Wrapper().getAllPostsByNewest().then((val) {
        setState(() {
          PostsStream = val;
        });
      });
    } else if (FilterState == 'Most Liked') {
      Wrapper().getAllPostsByLikes().then((val) {
        setState(() {
          PostsStream = val;
        });
      });
    } else if (FilterState == 'Most Commented') {
      Fluttertoast.showToast(msg: 'TO BE IMPLEMENTED');
      Wrapper().getAllPosts().then((val) {
        setState(() {
          PostsStream = val;
        });
      });
    }
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
                    if (thismodel['timestamp'] == null) {
                      return Container();
                    }
                    ;
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

  Widget FeedPostTile(
      {required String creator,
      required String text,
      required String createdAt,
      required int likes,
      required String id}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@$creator',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141), fontSize: 18),
                ),
                Text(
                  text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 19),
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
          ),
          //Spacer(),
          Row(children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CommentScreen(creator, text, createdAt, id)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 37, 237, 160),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Tap In', style: TextStyle(fontSize: 16)),
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
            Text(
              '$likes',
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ]),
        ],
      ),
    );
  }

  addLike(id, likes) async {
    await Wrapper().addPostLike(id, likes);
  }

  showFilterDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filters:'),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.start,
              buttonPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                RaisedButton(
                  child: Text("Newest"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    FilterState = "Newest";
                    getposts();
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text("Most Liked"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    FilterState = "Most Liked";
                    getposts();
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text("Most Commented"),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {
                    FilterState = "Most Commented";
                    getposts();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            FlatButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${FilterState}'), actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                showFilterDialog(context);
              },
              child: Icon(Icons.filter_list),
            )),
      ]),
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
          //Icons.,
          color: Colors.black,
        ),
      ),
    );
  }
}
