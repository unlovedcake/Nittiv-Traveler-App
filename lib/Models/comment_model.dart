import '../Core/Utils/nittiv-user-type.dart';
import '../Entities/comment.dart';
import 'operator_user_model.dart';
import 'traveler_user_model.dart';

class CommentModel extends Comment {
  const CommentModel({
    required super.commentId,
    required super.postId,
    required super.createdAt,
    required super.updatedAt,
    required super.user,
    required super.description,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    final userDoc = map['userDoc'] as Map<String, dynamic>;

    return CommentModel(
      createdAt:
          DateTime.tryParse(map['createdAt'] as String? ?? '') ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(map['updatedAt'] as String? ?? '') ?? DateTime.now(),
      commentId: map['commentId'] != null ? map['commentId'] as String : '',
      postId: map['postId'] as String? ?? '',
      user: userDoc['user_type'] == null ||
              userDoc['user_type'] == NittivUserType.traveler.name
          ? TravelerUserModel.fromMap(userDoc)
          : OperatorUserModel.fromMap(userDoc),
      description: map['description'] as String? ?? '',
    );
  }
}
