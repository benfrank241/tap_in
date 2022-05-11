import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
   //String? id;
   String? creator;
   String? text;
   Timestamp? timestamp;

  PostModel({
     //this.id,
     this.creator,
     this.text,
     this.timestamp,
  });

  factory PostModel.fromMap(Map) {
    return PostModel(
      //id: Map['id'],
      creator: Map['creator'],
      text: Map['text'],
      timestamp: Map['timestamp']
    );
  }

  Map<String, dynamic> tomap() {
    return {
      //'id': id,
      'creator': creator,
      'text': text,
      'timestamp': timestamp,
    };
  }

}
