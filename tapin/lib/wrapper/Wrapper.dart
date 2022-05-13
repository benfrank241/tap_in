import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tapin/Constants.dart';

class Wrapper {
  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  getUserByUsername(String Username) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: Username)
        .get();
  }

  createChatRoom(String chatRoomID, chatRoomMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: false)
        .snapshots();
    //.get();
  }

  getChatRooms(String userName) async {
    return await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: userName)
        .snapshots();
  }

  savePost(text) async {
    await FirebaseFirestore.instance.collection("posts").add({
      'username': Constants.myName,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'likes': 0,
    });
  }

  addPostLike(id, likes) async {
    int newlikes = likes + 1;
    await FirebaseFirestore.instance.collection('posts').doc(id).update({
      'likes': newlikes,
    });
  }

  getPostLikes(id) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('reactions')
        .get();
  }

  getPostByContent(String Content) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        // .where('text', isEqualTo: Content)
        //.orderBy('createdAt', descending: false)
        .where('text', isGreaterThanOrEqualTo: Content)
        .where('text', isLessThan: Content + 'z')
        .snapshots();
    //.get();
  }

  getAllPosts() async {
    return await FirebaseFirestore.instance.collection('posts').snapshots();
  }

  addComment(text, id) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .collection('comments')
        .add({
      'createdBy': Constants.myName,
      'timestamp': FieldValue.serverTimestamp(),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'comment': text,
    });
  }
}
