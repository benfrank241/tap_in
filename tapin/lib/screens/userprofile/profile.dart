import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/wrapper/Wrapper.dart';
import '../../model/user_model.dart';
import '../../widgets/tabbedwindow/UserSettingsTabbed.dart';
import '../feed/LocalWidgets/Comments.dart';
import '../mainrouter/mainrouter.dart';

void main() => runApp(MaterialApp(
      home: ProfileApp(),
    ));

class ProfileApp extends StatefulWidget {
  ProfileApp({Key? key}) : super(key: key);

  @override
  _ProfileAppState createState() => new _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel LoggedInuser = UserModel();

  Stream? yourPostStream;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.LoggedInuser = UserModel.fromMap(value.data());
      setState(() {});
    });
    GetYourPostsList();
  }

  GetYourPostsList() {
    Wrapper().getPostsByUsername(Constants.myName).then((val) {
      setState(() {
        yourPostStream = val;
      });
    });
  }

  GetTheirPostsList(String searchedUser) {
    Wrapper().getPostsByUsername(searchedUser).then((val) {
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
                    "assets/images/fire_outline.png",
                    height: 25,
                    width: 25,
                  )),
            ),
            Text(
              '$likes',
              style: TextStyle(color: Colors.white),
            ),
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
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => mainRouter()))
              },
              child: Image.asset('assets/images/icon.png'),
            )),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 100),
                          RawMaterialButton(
                            fillColor: Color.fromARGB(255, 255, 183, 255),
                            shape: CircleBorder(),
                            child: Icon(Icons.add_a_photo,
                                color: Colors.black, size: 18),
                            onPressed: () {
                              Fluttertoast.showToast(msg: 'To be implemented');
                            },
                          ),
                        ],
                      ),
                      Text(
                        '@${LoggedInuser.username}',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      SizedBox(height: 15),
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
              child: Row(
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
                        "Posts",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'To be implemented');
                    },
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    elevation: 0.0,
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 100.0, minHeight: 40.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Comments",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Color.fromARGB(200, 96, 94, 92),
          ),
          yourPostList(),
        ],
      ),
    );
  }
}
