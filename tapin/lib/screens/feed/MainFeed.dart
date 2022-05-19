import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/DirectChat/LocalWidgets/Conversation_screen.dart';
import 'package:tapin/wrapper/Wrapper.dart';
import 'package:flutter/cupertino.dart';
import '../../helper/helperfunctions.dart';
import '../../model/chat_model.dart';
import 'LocalWidgets/Comments.dart';

class MainFeed extends StatefulWidget {
  @override
  _MainFeed createState() => _MainFeed();
}

class _MainFeed extends State<MainFeed> {
  Stream? PostsStream;
  TextEditingController postText = TextEditingController();

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
                    if (thismodel['text'] == null) {
                      return Container();
                    }
                    return FeedPostTile(
                      creator: thismodel['username'],
                      text: thismodel['text'],
                      createdAt: thismodel['timestamp']
                          .toDate()
                          .toString()
                          .substring(5, 16),
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
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CommentScreen(creator, text, createdAt, id)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '@$creator',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 148, 144, 141),
                          fontSize: 18),
                    ),
                    Text(
                      text,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    Container(
                      width: 180,
                      child: Text(
                        '$createdAt',
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            color: Color.fromARGB(255, 148, 144, 141),
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Spacer(),
            Row(children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 CommentScreen(creator, text, createdAt, id)));
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Color.fromARGB(255, 37, 237, 160),
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              //     child: Text('Tap In', style: TextStyle(fontSize: 16)),
              //   ),
              // ),
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
                    // padding: EdgeInsets.all(12),
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
        const Divider(
          height: 30,
          thickness: 2,
          indent: 0,
          endIndent: 0,
          color: Color.fromARGB(255, 45, 45, 45),
        ),
      ]),
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
          backgroundColor: Color.fromARGB(255, 50, 50, 50),
          title: Text(
            'Filters:',
            style: TextStyle(color: Color.fromARGB(255, 196, 196, 196)),
          ),
          actions: [
            ButtonBar(
              alignment: MainAxisAlignment.center,
              buttonMinWidth: 300,
              buttonPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              children: [
                RaisedButton(
                  child: Text(
                    "Newest",
                    // style: TextStyle(color: Colors.black),
                  ),
                  textColor: Colors.black,
                  color: Color.fromARGB(255, 196, 196, 196),
                  onPressed: () {
                    FilterState = "Newest";
                    getposts();
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text("Most Liked"),
                  textColor: Colors.black,
                  color: Color.fromARGB(255, 196, 196, 196),
                  onPressed: () {
                    FilterState = "Most Liked";
                    getposts();
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  child: Text("Most Commented"),
                  textColor: Colors.black,
                  color: Color.fromARGB(255, 196, 196, 196),
                  onPressed: () {
                    FilterState = "Most Commented";
                    getposts();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            FlatButton(
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Color.fromARGB(255, 196, 196, 196),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  addPostPopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Post:'),
            content: TextField(
              controller: postText,
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
                  if (postText.text == '') {
                    Fluttertoast.showToast(msg: 'Please enter some text');
                  } else {
                    Wrapper().savePost(postText.text);
                    Fluttertoast.showToast(msg: 'Posted');
                    postText.clear();
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
      appBar:
          AppBar(title: Text('${FilterState}'), centerTitle: true, actions: [
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
          //   Navigator.of(context)
          //      .push(MaterialPageRoute(builder: (context) => Add()));
          addPostPopUp(context);
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
