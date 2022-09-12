import '../Entities/like.dart';
import '../Entities/nittiv_user.dart';

class LikeModel extends Like {
  const LikeModel(
      {required super.liked,
      required super.postId,
      required super.latestUserWhoLiked,
      required super.updatedAt});

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    final userDoc = map['userDoc'] as NittivUser;
    var updatedAt = map['updatedAt'] as DateTime;

    return LikeModel(
        liked: map['liked'] as bool? ?? false,
        updatedAt: updatedAt.toLocal(),
        postId: map['postId'] as String? ?? '',
        latestUserWhoLiked: userDoc);
  }
}
