import 'package:flutter/material.dart';
import 'package:tapin/Constants.dart';
import 'package:tapin/screens/DirectChat/LocalWidgets/Conversation_screen.dart';
import 'package:tapin/wrapper/Wrapper.dart';

import '../../helper/helperfunctions.dart';
import '../../model/chat_model.dart';
import 'LocalWidgets/Search.dart';

class chatRoom extends StatefulWidget {
  @override
  _chatRoomState createState() => _chatRoomState();
}

class _chatRoomState extends State<chatRoom> {
  Stream? chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  //chatModel thismodel =
                  //chatModel.fromMap(snapshot.data.docs[index].data());
                  Map thismodel = snapshot.data.docs[index].data();
                  return chatRoomTiles(
                    userName: thismodel['chatRoomId']
                        .toString()
                        .replaceAll('_', '')
                        .replaceAll(Constants.myName, ''),
                    chatRoomId: thismodel['chatRoomId'],
                  );
                })
            : Container(
                // child: Text(
                //   "I WAS EMPTY BRUH!",
                //   style: TextStyle(color: Colors.white),
                // ),
                );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    // print('${Constants.myName} GETUSERINFO OUTPUT');
    Wrapper().getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomStream = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => searchScreen()));
        },
      ),
    );
  }
}

class chatRoomTiles extends StatelessWidget {
  final String? userName;
  final String? chatRoomId;

  chatRoomTiles({this.userName, this.chatRoomId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId!)))
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text('${userName?.substring(0, 1).toUpperCase()} ')),
          SizedBox(
            width: 8,
          ),
          Text(userName!, style: TextStyle(color: Colors.white)),
        ]),
      ),
    );
  }
}
