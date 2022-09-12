import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? postId;
  String? likeId;
  bool? like;
  Map? user;
  String? comment;
  DateTime? createdAt;



  CommentModel(
      {this.id,
        this.postId,
        this.likeId,
        this.like,
        this.user,
        this.comment,
        this.createdAt,
       });

  // receiving data from server
  factory CommentModel.fromMap(map) {
    return CommentModel(
      id: map['id'],
      postId: map['postId'],
     likeId: map['likeId'],
      like: map['like'],
      user: map['user'],
      comment: map['comment'],
      createdAt: map['createdAt'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'postId': postId,
      'likeId': likeId,
      'like': like,
      'user': user,
      'comment': comment,
      'createdAt': createdAt,

    };
  }


  factory CommentModel.fromDocumentSnapshot({required DocumentSnapshot<Map<String,dynamic>> doc}){
    return CommentModel(
      id: doc.data()!["id"],
      user: doc.data()!["user"],
      comment:doc.data()!["comment"],
    );
  }
}
