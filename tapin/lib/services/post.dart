import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tapin/Constants.dart';

class PostService {
  Future savePost(text) async {
    await FirebaseFirestore.instance.collection("posts").add({
      'username': Constants.myName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
