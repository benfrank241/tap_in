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
              createChatroomAndStartConversation(userName);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text('Message'),
            ),
          ),
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
              color: Color.fromARGB(82, 207, 19, 19),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEdittingController,
                    decoration: InputDecoration(
                      hintText: 'Enter a Username...',
                      hintStyle: TextStyle(
                        color: Colors.grey,
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
