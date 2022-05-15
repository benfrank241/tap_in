import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/userprofile/profile.dart';
import 'package:tapin/wrapper/Wrapper.dart';
import '../../model/user_model.dart';
import '../../widgets/tabbedwindow/UserSettingsTabbed.dart';
import '../feed/LocalWidgets/Comments.dart';

class SearchedProfileApp extends StatefulWidget {
  final String username;

  SearchedProfileApp({required this.username});

  @override
  _SearchedProfileAppState createState() => new _SearchedProfileAppState();
}

class _SearchedProfileAppState extends State<SearchedProfileApp> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel LoggedInuser = UserModel();

  Stream? yourPostStream;

  @override
  void initState() {
    super.initState();
    GetUserPostsList();
  }

  GetUserPostsList() {
    Wrapper().getPostsByUsername(widget.username).then((val) {
      setState(() {
        yourPostStream = val;
      });
    });
  }

  Widget yourPostList() {
    return Expanded(
      child: StreamBuilder(
        stream: yourPostStream,
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
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                child: Text('Tap In'),
              ),
            ),
            GestureDetector(
              onTap: () {
                // addLike(id, likes);
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        title: Container(
          width: 90,
          child: Image.asset('assets/images/icon.png'),
        ),
        actions: <Widget>[
          IconButton(
            iconSize: 40,
            icon: Icon(Icons.person, color: Color.fromARGB(255, 255, 183, 255)),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfileApp()));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Color.fromARGB(255, 255, 183, 255),
                    Color.fromARGB(255, 37, 237, 160)
                  ])),
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/default.jpg'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 22.0),
                        ),
                        radius: 50.0,
                      ),
                      Text(
                        '@${widget.username}',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.transparent,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 28.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "345",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "Communities",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "26",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
          // Divider(
          //     height: 20,
          //     thickness: 10,
          //     color: Color.fromARGB(255, 37, 237, 160)
          // ),
          Container(
            width: 10000,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {},
                    color: Color.fromARGB(255, 255, 183, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "${widget.username}'s posts",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  // Text(
                  //   "feed:",
                  //   style: TextStyle(
                  //       color: Colors.purpleAccent[100],
                  //       fontStyle: FontStyle.normal,
                  //       fontSize: 28.0),
                  // ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Text(
                  //   'filler filler filler.\n'
                  //   'temp temp temp.',
                  //   style: TextStyle(
                  //     fontSize: 22.0,
                  //     fontStyle: FontStyle.italic,
                  //     fontWeight: FontWeight.w300,
                  //     color: Colors.black,
                  //     letterSpacing: 2.0,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          yourPostList(),
        ],
      ),
    );
  }
}
