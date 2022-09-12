class PostModel {
  String? id;
  Map? user;
  String? body;
  String? imagePost;
  String? emailSaNagLike;
  int? countComment;
  bool? like;
  DateTime? createdAt;



  PostModel(
      {this.id,
        this.user,
        this.body,
        this.imagePost,
        this.emailSaNagLike,
        this.countComment,
        this.like,
        this.createdAt,
       });

  // receiving data from server
  factory PostModel.fromMap(map) {
    return PostModel(
      id: map['id'],
      user: map['user'],
      body: map['body'],
      imagePost: map['imagePost'],
      emailSaNagLike: map['emailSaNagLike'],
      countComment: map['countComment'],
      like: map['like'],
      createdAt: map['createdAt'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'body': body,
      'imagePost': imagePost,
      'emailSaNagLike': emailSaNagLike,
      'countComment': countComment,
      'like': like,
      'createdAt': createdAt,
    };
  }
}
