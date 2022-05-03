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
}
