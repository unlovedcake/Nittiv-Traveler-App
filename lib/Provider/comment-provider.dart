import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Models/CommentModel.dart';

class CommentProvider with ChangeNotifier {
  bool isVisible = false;
  int index = 0;

  int? countComments = 8;

  setCountComment(int comment) {
    countComments = comment;
    notifyListeners();
  }

  int get getCountComments => countComments!;

  setVisible(bool isVisibled) {
    isVisible = isVisibled;
    notifyListeners();
  }

  bool get getVisible => isVisible;

  createComment(CommentModel commentModel, BuildContext context) async {
    try {
      FirebaseFirestore.instance
          .collection("table-post")
          .doc(commentModel.postId)
          .collection("table-comment")
          .add(commentModel.toMap())
          .whenComplete(() async {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentReference postRef = FirebaseFirestore.instance
              .collection('table-like')
              .doc(commentModel.id);

          DocumentSnapshot snapshot = await transaction.get(postRef);
          int commentCount = snapshot.get("commentCount");

          transaction.update(postRef, {'commentCount': commentCount + 1});
        });

        Fluttertoast.showToast(
          msg: "Comment created successfully :) ",
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.CENTER_RIGHT,
        );
      });
    } catch (e) {}
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> displayComments(String postId) {

     return FirebaseFirestore.instance
        .collection('table-comments')
        .doc(postId)
        .collection(postId)
        //.limit(countComments!)
        .orderBy("createdAt", descending: true)
        .snapshots();

  }

  Stream<DocumentSnapshot> displayComment(String postId) {
    return FirebaseFirestore.instance
        .collection("table-comment")
        .doc(postId)
        .snapshots();
  }

  // setVisibleTextComment(bool visible) {
  //   isVisible = visible;
  //   notifyListeners();
  // }
  //
  // bool get getVisibleTextComment => isVisible;

  List<bool> isShowTextFieldComment = [];

  setShowTextFieldComment(int indx, bool isShow) {
    isShowTextFieldComment[indx] = isShow;

    notifyListeners();
  }

  bool getShowTextFieldComment(int index) {
    return isShowTextFieldComment[index];
  }

  showOnlyPostTextFieldComment() async {
    try {
      final res =
          await FirebaseFirestore.instance.collection("table-post").get();

      for (var doc in res.docs) {
        isShowTextFieldComment.add(false);
      }
      notifyListeners();
    } catch (e) {
      return null;
    }
  }
}
