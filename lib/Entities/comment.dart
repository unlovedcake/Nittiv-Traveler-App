// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'nittiv_user.dart';

class Comment extends Equatable {
  final String? commentId;
  final String postId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NittivUser user;
  final String description;
  const Comment({
    this.commentId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.description,
  });

  @override
  List<Object> get props {
    return [
      commentId ?? '',
      postId,
      user,
      description,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Comment copyWith({
    String? commentId,
    String? postId,
    NittivUser? user,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Comment(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      user: user ?? this.user,
      description: description ?? this.description,
    );
  }
}
