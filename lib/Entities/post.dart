// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'comment.dart';
import 'nittiv_user.dart';

class Post extends Equatable {
  final String? userId;
  final String? username;
  final String? userImageUrl;
  final String postId;
  final String? imageUrl;
  final String? location;
  final String? content;
  final int? totalLikes;
  final bool? liked;
  final String? whoLastLiked;
  final int? commentCount;
  final List<Comment>? comments;
  final List<NittivUser>? interactors;
  const Post(
      {this.userId,
      this.username,
      this.userImageUrl,
      required this.postId,
      this.totalLikes,
      this.liked,
      this.whoLastLiked,
      this.imageUrl,
      this.location,
      this.comments,
      this.commentCount,
      required this.content,
      this.interactors});

  @override
  List<Object> get props {
    return [
      userId ?? '',
      username ?? '',
      userImageUrl ?? '',
      postId,
      imageUrl ?? '',
      location ?? '',
      content ?? '',
      comments ?? [],
      interactors ?? [],
    ];
  }

  Post copyWith({
    String? userId,
    String? username,
    String? userImageUrl,
    String? postId,
    String? description,
    String? imageUrl,
    String? location,
    String? content,
    int? commentCount,
    List<Comment>? comments,
    List<NittivUser>? interactors,
  }) {
    return Post(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      userImageUrl: userImageUrl ?? this.userImageUrl,
      postId: postId ?? this.postId,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      content: content ?? this.content,
      commentCount: commentCount ?? this.commentCount,
      comments: comments ?? this.comments,
      interactors: interactors ?? this.interactors,
    );
  }
}
