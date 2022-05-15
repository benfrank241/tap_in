import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/mainrouter/mainrouter.dart';
import 'package:tapin/screens/userprofile/searchedProfile.dart';
import '../../model/post.dart';
import '../../model/user_model.dart';
import '../../wrapper/Wrapper.dart';
import '../feed/LocalWidgets/Comments.dart';
import '../userprofile/profile.dart';

class Discover extends StatefulWidget {
  @override
  DiscoverState createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  TextEditingController searchTextEdittingController =
      new TextEditingController();

  QuerySnapshot? searchSnapshot;

  UserModel? searchedUser;

  Stream? searchSnapshotPost;

//search User

  initiateSearch() {
    if (searchTextEdittingController != '') {
      String thisString = searchTextEdittingController.text.replaceAll('@', '');
      Wrapper().getUserByUsername(thisString).then((val) {
        setState(() {
          searchSnapshot = val;
          searchedUser = UserModel.fromMap(searchSnapshot?.docs[0].data());
          searchSnapshotPost = null;
        });
      });
    } else {
      searchSnapshotPost = null;
      searchSnapshot = null;
      searchedUser = null;
    }
  }

  Widget searchList() {
    return searchedUser != null
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchSnapshot?.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              //print(searchedUser?.username);
              return searchTile(
                userName: searchedUser?.username ?? '',
                userEmail: searchedUser?.email ?? '',
              );
            },
          )
        : Container();
  }

  Widget searchTile({required String userName, required String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName),
              Text(userEmail),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if (Constants.myName == userName) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileApp()));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchedProfileApp(
                          username: userName,
                        )));
              }
              ;
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 37, 237, 160),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('View Profile'),
            ),
          ),
        ],
      ),
    );
  }

//End Search User

//Search Post

  initiateSearchPost() {
    if (searchTextEdittingController.text != '') {
      Wrapper().getPostByContent(searchTextEdittingController.text).then((val) {
        setState(() {
          searchSnapshotPost = val;
          searchSnapshot = null;
          searchedUser = null;
        });
      });
    } else {
      setState(() {
        searchSnapshotPost = null;
        searchSnapshot = null;
        searchedUser = null;
      });
    }
  }

  Widget searchListPost() {
    if (searchSnapshotPost == null) {
      return Container();
    } else {
      return Expanded(
        child: StreamBuilder(
          stream: searchSnapshotPost,
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
                        id: snapshot.data.docs[index].id,
                        likes: thismodel['likes'],
                      );
                    })
                : Container();
          },
        ),
      );
    }
  }

  Widget searchTilePost(
      {required String creator,
      required String text,
      required String createdAt,
      required String id,
      required int likes}) {
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
                //addLike(id, likes);
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

//EndSsearch Post

  Widget clearTile() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: const <Widget>[
        Text("I'm dedicating every day to you"),
        Text('Domestic life was never quite my style'),
        Text('When you smile, you knock me out, I fall apart'),
        Text('And I thought I was so smart'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Use @ to search for profiles")),
        body: Container(
          child: Column(children: [
            Container(
              color: Color.fromARGB(150, 255, 183, 255),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEdittingController,
                    decoration: InputDecoration(
                      hintText: 'Search Tap-in',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      if (searchTextEdittingController.text == '') {
                        setState(() {
                          print('shit should be empty');
                          searchSnapshotPost = null;
                          searchSnapshot = null;
                          searchedUser = null;
                        });
                      } else if (searchTextEdittingController.text
                              .substring(0, 1) ==
                          '@') {
                        initiateSearch();
                      } else {
                        initiateSearchPost();
                      }
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(54, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Image.asset(
                          "assets/images/search_white.png",
                          height: 25,
                          width: 25,
                        )),
                  ),
                ],
              ),
            ),
            searchList(),
            searchListPost(),
          ]),
        ));
  }
}
