import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nittiv_new_version/Models/CommentModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../Core/Utils/nittiv-color.dart';
import '../../Models/UserModel.dart';
import '../../Provider/comment-provider.dart';

class ShowTextCommentField extends StatefulWidget {
  final DocumentSnapshot post;
  final int index;

  const ShowTextCommentField({
    Key? key,
    required this.post,
    required this.index,
  }) : super(key: key);

  @override
  State<ShowTextCommentField> createState() => _ShowTextCommentFieldState();
}

class _ShowTextCommentFieldState extends State<ShowTextCommentField> {
  String commentText = '';
  User? user = FirebaseAuth.instance.currentUser;

  UserModel? loggedInUser = UserModel();

  loggedInUserInfo() async {
    final res = await FirebaseFirestore.instance
        .collection("table-user")
        .where('email', isEqualTo: user!.email)
        .get();

    for (var doc in res.docs) {
      loggedInUser = UserModel.fromMap(doc.data());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loggedInUserInfo();

    return TextFormField(
      autofocus: true,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 4,
      onChanged: (value) => {setState(() => commentText = value)},
      decoration: InputDecoration(
          hintText: "   Write Comment",
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(10),
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: NittivColors.primaryGreen, width: 1.0),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(8),
            child: CachedNetworkImage(
              imageUrl: widget.post['user']['userImage'] ?? "",
              imageBuilder: (context, imageProvider) => Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                strokeWidth: 1,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          suffixIcon: IconButton(
              onPressed: () {
                int count = Provider.of<CommentProvider>(context,listen: false).getCountComments;
                CommentModel commentModel = CommentModel()
                  ..id = const Uuid().v4()
                  ..postId = widget.post.id
                  ..likeId = widget.post['id']
                  ..like = false
                  ..comment = commentText
                  ..createdAt = DateTime.now()
                  ..user = {
                    'userId': widget.post['user']['userId'],
                    'userName': widget.post['user']['userName'],
                    'userImage': widget.post['user']['userImage'],
                    'userCommentName': loggedInUser!.firstName.toString(),
                    'userCommentEmail': loggedInUser!.email.toString(),
                    'userCommentImage': loggedInUser!.imageUrl.toString(),
                  };

                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection("table-comments")
                    .doc(widget.post.id)
                    .collection(widget.post.id)
                    .doc(DateTime.now().millisecondsSinceEpoch.toString());

                FirebaseFirestore.instance.runTransaction((transaction) async {
                  transaction.set(documentReference, commentModel.toMap());
                }).then((uid) async {
                  await FirebaseFirestore.instance
                      .runTransaction((transaction) async {
                    DocumentReference postRef = FirebaseFirestore.instance
                        .collection('table-like')
                        .doc(widget.post.id)
                      .collection(widget.post.id).doc(widget.post.id);

                    DocumentSnapshot snapshot = await transaction.get(postRef);

                    if (!snapshot.exists) {

                      DocumentReference documentReference = FirebaseFirestore
                          .instance
                          .collection("table-like")
                          .doc(widget.post.id)
                          .collection(widget.post.id)
                          .doc(widget.post.id);

                      FirebaseFirestore.instance
                          .runTransaction((transaction) async {
                        transaction.set(
                          documentReference,
                          {
                            "postId": widget.post.id,
                            "like": false,
                            "commentCount" : 1,
                            "emailSaNagLike": "",
                            "userName": "",
                          },
                        );
                      }).whenComplete(() async {});

                    }
                    int commentCount = snapshot.get("commentCount");

                    transaction
                        .update(postRef, {'commentCount': commentCount + 1});
                  });
                });

                print("Comment");
                //
                //  FirebaseFirestore.instance.runTransaction((transaction)async{
                //   DocumentReference postRef = FirebaseFirestore.instance.collection('table-like')
                //       .doc(widget.post['id']);
                //
                //   DocumentSnapshot snapshot = await transaction.get(postRef);
                //   int commentCount = snapshot.get("commentCount");
                //
                //   transaction.update(postRef,{
                //     'commentCount' : commentCount + 1
                //   });
                // });
                //
                // context
                //     .read<CommentProvider>()
                //     .createComment(commentModel, context);
              },
              icon: const Icon(
                Icons.send,
                color: NittivColors.primaryGreen,
              ))),
    );
  }
}
