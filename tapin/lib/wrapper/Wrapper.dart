import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper {
  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return FirebaseFirestore.instance
          .collection(collectionPath)
          .limit(limit)
          .where("displayName", isEqualTo: textSearch)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }
}
