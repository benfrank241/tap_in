import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? username;
  String? text;
  Timestamp? timestamp;

  PostModel({
    this.username,
    this.text,
    this.timestamp,
  });

  factory PostModel.fromMap(Map) {
    return PostModel(
        username: Map['username'],
        text: Map['text'],
        timestamp: Map['timestamp']);
  }

  Map<String, dynamic> tomap() {
    return {
      'username': username,
      'text': text,
      'timestamp': timestamp,
    };
  }
}
