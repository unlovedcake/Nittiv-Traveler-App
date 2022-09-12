import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Entities/comment.dart';
import '../../Models/comment_model.dart';
import '../Exceptions/nittiv_exceptions.dart';

class CommentService {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Comment>> getComments(String postId) async {
    try {
      final result = await _firestoreInstance
          .collection('comments')
          .where('postId', isEqualTo: postId)
          .get();

      List<Comment> comments = [];

      final userDocs = result.docs.map(
        (doc) {
          return (doc.data()['userRef'] as DocumentReference).get();
        },
      ).toList();

      for (int i = 0; i < result.docs.length; i++) {
        comments.add(CommentModel.fromMap({
          'commentId': result.docs[i].id,
          'postId': result.docs[i]['postId'] as String,
          'userDoc': (await userDocs[i]).data(),
          'description': result.docs[i]['description'] as String,
        }));
      }

      return comments;
    } on StateError {
      return [];
    } catch (e) {
      log('getComments error $e');
      throw const NittivCommonException(message: 'Fetching Comments failed');
    }
  }

  Future<Comment> addComment(Comment comment) async {
    try {
      final postDoc =
          _firestoreInstance.collection("posts").doc(comment.postId);
      await _firestoreInstance.runTransaction((transaction) async {
        final snapshot = await transaction.get(postDoc);
        final data = snapshot.data();
        final comments = data?['totalComments'];
        var newComment = 1;

        if (data != null &&
            !data.containsKey('totalComments') &&
            comments?['Null'] == null) {
          // there is a Null: null object returned
          // if totalComments is not set in firestore yet
          return transaction.update(postDoc, {"totalComments": newComment});
        }

        newComment = comments + 1;
        return transaction.update(postDoc, {"totalComments": newComment});
      });

      final userRef =
          _firestoreInstance.collection('users').doc(comment.user.uid);

      final result = await _firestoreInstance
          .collection("comments")
          .add(comment.toMap()..addEntries({'userRef': userRef}.entries));

      final commentRef = await result.get();

      return comment.copyWith(commentId: commentRef.id);
    } catch (e) {
      log('Comment Creation Error $e');
      throw const NittivCommonException(message: 'Add comment failed');
    }
  }
}
