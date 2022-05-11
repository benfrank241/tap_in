// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../model/post.dart';

// class PostService {
//   List<PostModel> _postListFromSnapshot(
//       QuerySnapshot<Map<String, dynamic>> snapshot) {
//     return snapshot.docs.map((doc) {
//       return PostModel(
//         username: doc.data()['username'] ?? '',
//         text: doc.data()['text'] ?? '',
//         timestamp: doc.data()['timestamp'] ?? 0,
//       );
//     }).toList();
//   }

//   Future savePost(text) async {
//     await FirebaseFirestore.instance.collection("posts").add({
//       'username': FirebaseAuth.instance.currentUser?.uid,
//       'text': text,
//       'timestamp': FieldValue.serverTimestamp()
//     });
//   }

//   Stream<List<PostModel>> getPostsByUser(uid) {
//     return FirebaseFirestore.instance
//         .collection("posts")
//         .where('creator', isEqualTo: uid)
//         .snapshots()
//         .map(_postListFromSnapshot);
//   }
// }
