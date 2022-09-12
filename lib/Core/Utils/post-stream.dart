// this class takes in parameters to make collection snapshots to be used for streams
import 'package:cloud_firestore/cloud_firestore.dart';

class PostStream {
  final String collectionName;
  final bool desc;
  final String orderBy;
  const PostStream(
    this.collectionName,
    this.desc,
    this.orderBy,
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> createStream() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .orderBy(
          orderBy,
          descending: desc,
        )
        .snapshots();
  }
}
