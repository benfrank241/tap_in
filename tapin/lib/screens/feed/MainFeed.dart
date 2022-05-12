import 'package:flutter/material.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/DirectChat/LocalWidgets/Conversation_screen.dart';
import 'package:tapin/wrapper/Wrapper.dart';

import '../../helper/helperfunctions.dart';
import '../../model/chat_model.dart';
import '../posts/add.dart';

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
                    return searchTilePost(
                      creator: thismodel['username'],
                      text: thismodel['text'],
                      createdAt: thismodel['timestamp'].toDate().toString(),
                    );
                  })
              : Container();
        },
      ),
    );
  }

  Widget searchTilePost(
      {required String creator,
      required String text,
      required String createdAt}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('@$creator - $createdAt',
                style: const TextStyle(color: Color.fromARGB(255, 148, 144, 141)),),
              Text(text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                fontSize: 17),
              ),
            ],
          ),
          ),

          //Spacer(),
          GestureDetector(
            onTap: () {
              //viewProfile();
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
        ],
      ),
    );
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
        child: Icon(Icons.add,
        color: Colors.black,),
      ),
    );
  }
}
