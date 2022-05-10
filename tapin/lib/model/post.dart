import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String creator;
  final String text;
  final Timestamp timestamp;

  PostModel({
    required this.id,
    required this.creator,
    required this.text,
    required this.timestamp,
  });

  factory PostModel.fromMap(Map) {
    return PostModel(
      id: Map['id'],
      creator: Map['creator'],
      text: Map['text'],
      timestamp: Map['timestamp']
    );
  }

  Map<String, dynamic> tomap() {
    return {
      'id': id,
      'creator': creator,
      'text': text,
      'timestamp': timestamp,
    };
  }

}
