import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import '../../model/user_model.dart';
import '../../wrapper/Wrapper.dart';

class Discover extends StatefulWidget {
  @override
  DiscoverState createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
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
              //createChatroomAndStartConversation(userName);
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
    int _selectedIndex = 2;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;

        if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Discover()));
        }

        if (index == 1) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Feed()));
        }
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
          "Use @ to search for profiles"
          )
        ),
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
                          hintText: 'Search Tap-in',
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
