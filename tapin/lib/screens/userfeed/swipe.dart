import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

// Link to DB
final List data = [
  {
    'image': Image.asset("assets/logo3.png"),
  },
  {
    'image': Image.asset("assets/logo.png"),
  },
  {
    'image': Image.asset("assets/logo3.png"),
  },
];

class Tinder extends StatefulWidget {
  @override
  _TinderState createState() => _TinderState();
}

class _TinderState extends State<Tinder> {
  // Dynamically load cards from database
  List<Card> cards = [
    Card(
      data[0]['image'],
    ),
    Card(
      data[1]['image'],
    ),
    Card(
      data[2]['image'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Stack of cards that can be swiped. Set width, height, etc here.
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      // Important to keep as a stack to have overlay of cards.
      child: Stack(
        children: cards,
      ),
    );
  }
}

class Card extends StatelessWidget {
  // Made to distinguish cards
  // Add your own applicable data here
  final Image image;
  Card(this.image);

  @override
  Widget build(BuildContext context) {
    return Swipable(
      // Set the swipable widget
      child: Container(
        child: image, height: 1000,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
            color: Color.fromARGB(255, 190, 190, 190),
        ),
      ),

      // onSwipeRight, left, up, down, cancel, etc...
    );
  }
}
