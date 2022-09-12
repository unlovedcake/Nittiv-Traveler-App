import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Entities/nittiv_user.dart';
import '../../Entities/post.dart';
import '../Exceptions/nittiv_exceptions.dart';

class PostService {
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<List<Post>> getNewsfeedPosts(NittivUser user) async {
    try {
      var result = await _firestoreInstance.collection('posts').limit(10).get();

      final userRef = _firestoreInstance.collection('users').doc(user.uid);
      List<Post> postList = [];
      for (var doc in result.docs) {
        var postId = doc.id.toString();

        var liked = await _firestoreInstance
            .collection("postLikes")
            .where("postId", isEqualTo: postId)
            .where("user", isEqualTo: userRef)
            .where("liked", isEqualTo: true)
            .get();

        var likedRes = false;
        if (liked.docs.isNotEmpty) {
          likedRes = true;
        }

        postList.add(
          Post(
              postId: postId,
              content: doc.data()['content'] ?? '',
              totalLikes: doc.data()['totalLikes'] ?? 0,
              username: doc.data()['username'] ?? '',
              liked: likedRes),
        );
      }

      return postList;
    } catch (e) {
      log('getPosts error $e');
      throw const NittivCommonException(message: 'Fetching Newsfeed failed');
    }
  }
}
