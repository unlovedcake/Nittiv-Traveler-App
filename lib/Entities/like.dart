// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'nittiv_user.dart';

class Like extends Equatable {
  final bool liked;
  final String postId;
  final NittivUser latestUserWhoLiked;
  final DateTime updatedAt;
  const Like(
      {required this.liked,
      required this.postId,
      required this.latestUserWhoLiked,
      required this.updatedAt});

  @override
  List<Object> get props {
    return [
      liked,
      postId,
      latestUserWhoLiked,
      updatedAt,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'liked': liked,
      'postId': postId,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Like copyWith({
    bool? liked,
    String? postId,
    NittivUser? latestUserWhoLiked,
    DateTime? updatedAt,
  }) {
    return Like(
      liked: liked ?? this.liked,
      postId: postId ?? this.postId,
      latestUserWhoLiked: latestUserWhoLiked ?? this.latestUserWhoLiked,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
