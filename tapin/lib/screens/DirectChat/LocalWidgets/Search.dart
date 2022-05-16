import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/model/user_model.dart';
import 'package:tapin/screens/DirectChat/LocalWidgets/Conversation_screen.dart';
import 'package:tapin/wrapper/Wrapper.dart';

class searchScreen extends StatefulWidget {
  @override
  _searchScreenState createState() => _searchScreenState();
}

class _searchScreenState extends State<searchScreen> {
  TextEditingController searchTextEdittingController =
      new TextEditingController();
  Wrapper wrapper = Wrapper();

  QuerySnapshot? searchSnapshot;
  UserModel? searchedUser;

  initiateSearch() {
    // print(Constants.myName);
    wrapper.getUserByUsername(searchTextEdittingController.text).then((val) {
      setState(() {
        searchSnapshot = val;
        searchedUser = UserModel.fromMap(searchSnapshot?.docs[0].data());
      });
    });
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

  createChatroomAndStartConversation(String username) {
    if (username != Constants.myName) {
      print(Constants.myName);
      String chatRoomId = getChatRoomId(username, Constants.myName);

      print(chatRoomId);

      List<String> users = [Constants.myName, username];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
      };

      Wrapper().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      Fluttertoast.showToast(msg: 'Talking to yourself is kinda sad no?');
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget searchTile({required String userName, required String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
            AssetImage('assets/images/default.jpg'),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 22.0),
            ),
            radius: 23.0,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@$userName',
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 19),
                ),
                Text(
                  userEmail,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color.fromARGB(255, 148, 144, 141), fontSize: 16),
                ),
              ],
            ),
          ),
          //Spacer(),
          Row(children: [
            GestureDetector(
              onTap: () {
                createChatroomAndStartConversation(userName);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 37, 237, 160),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text('Message', style: TextStyle(fontSize: 16)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
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
                      hintText: 'Enter a Username...',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      initiateSearch();
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
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
            ),
            searchList(),
          ]),
        ));
  }
}
