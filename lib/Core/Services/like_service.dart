import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Entities/like.dart';
import '../../Entities/nittiv_user.dart';
import '../../Entities/post.dart';
import '../../Models/like_model.dart';
import '../Exceptions/nittiv_exceptions.dart';

class LikeService {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<Like> processLikes(NittivUser user, bool liked, Post post) async {
    try {
      final postDoc = _firestoreInstance.collection("posts").doc(post.postId);
      await _firestoreInstance.runTransaction((transaction) async {
        final snapshot = await transaction.get(postDoc);
        final data = snapshot.data();
        final likes = data?['totalLikes'];
        var newLikes = 1;

        if (data != null &&
            !data.containsKey('totalLikes') &&
            likes?['Null'] == null) {
          // there is a Null: null object returned
          // if totalLikes is not set in firestore yet
          return transaction.update(postDoc, {"totalLikes": newLikes});
        }

        newLikes = liked ? likes + 1 : likes - 1;
        return transaction.update(postDoc, {"totalLikes": newLikes});
      });

      final postLike = await _firestoreInstance
          .collection("postLikes")
          .where('postId', isEqualTo: post.postId)
          .get();

      var updatedAt = DateTime.now();
      final userRef = _firestoreInstance.collection('users').doc(user.uid);

      if (postLike.size < 1) {
        await _firestoreInstance.collection("postLikes").add({
          "user": userRef,
          "postId": post.postId,
          "liked": liked,
          "updatedAt": updatedAt.toUtc()
        });
      } else {
        await _firestoreInstance
            .collection("postLikes")
            .doc(postLike.docs.first.id)
            .update({"liked": liked, "updatedAt": updatedAt.toUtc()});
      }

      return LikeModel.fromMap({
        'liked': liked,
        'postId': post.postId,
        'userDoc': user,
        'updatedAt': updatedAt
      });
    } catch (e) {
      log('process Likes error $e');
      throw const NittivCommonException(message: 'Process Likes failed');
    }
  }
}
