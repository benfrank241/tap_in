import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tapin/screens/userchats/localwidgets/Message.dart';
import 'package:tapin/screens/userfeed/feed.dart';
import 'package:tapin/widgets/NavBar.dart';

class Discover extends StatefulWidget {
  @override
  DiscoverState createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/DiscoverPlaceHolder/basketball.jpg',
      'assets/DiscoverPlaceHolder/car.jpg',
      'assets/DiscoverPlaceHolder/isabelle.jpg',
      'assets/DiscoverPlaceHolder/jesus.jpg',
      'assets/DiscoverPlaceHolder/pokemonball.jpg',
      'assets/DiscoverPlaceHolder/stroller.jpg',
      'assets/DiscoverPlaceHolder/tacos.jpg',
      'assets/DiscoverPlaceHolder/xbox.jpg'
    ];
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
      body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      Text("Discover \nNew Communities",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade700,
                              ),
                              border: InputBorder.none,
                              hintText: "Classic Style",
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade500)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Container(
                  child: TabBar(labelColor: Colors.black, tabs: [
                    Tab(
                      text: "Popular",
                    ),
                    Tab(
                      text: "New",
                    ),
                    Tab(
                      text: "Pain",
                    ),
                    Tab(
                      text: "Bleh",
                    ),
                  ]),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    GridView.custom(
                      gridDelegate: SliverWovenGridDelegate.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        pattern: [
                          WovenGridTile(1),
                          WovenGridTile(
                            5 / 7,
                            crossAxisRatio: 0.9,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(
                            color: Colors.black,
                            // child: Text(
                            //   _name[index],
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(color: Colors.white, fontSize: 40),
                            // ),
                            child: Image(image: AssetImage(images[index]))
                            // Image.network(
                            //   'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                            //   fit: BoxFit.cover,
                            // ),
                            //     Image.asset(
                            //   '$',
                            //   fit: BoxFit.cover,
                            // )
                            );
                      }, childCount: images.length),
                    ),
                    Center(),
                    Center(),
                    Center(),
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
