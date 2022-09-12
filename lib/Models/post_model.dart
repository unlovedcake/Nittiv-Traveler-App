import '../Entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.postId,
    required super.content,
    super.commentCount,
    userId,
    username,
    userImageUrl,
    imageUrl,
    location,
    comments,
    interactors,
  });
}
