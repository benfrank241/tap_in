import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final String creator;
  final String text;
  final String createdAt;
  final int likes;
  final String id;
  CommentScreen(this.creator, this.text, this.createdAt, this.likes, this.id);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${widget.creator} - ${widget.createdAt}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 148, 144, 141)),
                ),
                Text(
                  widget.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
