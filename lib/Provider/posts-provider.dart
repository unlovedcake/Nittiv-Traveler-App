import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../Models/PostModel.dart';
import '../Models/UserModel.dart';

class PostsProvider with ChangeNotifier {
  File? imageGallery = File("");
  bool? isNotEmptyImage = false;
  String? fileName = "";
  String? imageUrlPost = "";
  PickedFile? pickedImage = PickedFile("");

  Uint8List pickedFileBytess = Uint8List(10);

  setImageGallery(File image, Uint8List pickedFileBytes, pickedImaged,
      fileNamed, isNotEmptyImages) {
    fileName = fileNamed;
    pickedImage = pickedImaged;
    imageGallery = image;
    pickedFileBytess = pickedFileBytes;
    isNotEmptyImage = isNotEmptyImages;
    notifyListeners();
  }

  setImagePostUrl(String image) {
    imageUrlPost = image;
    notifyListeners();
  }

  String get getImagePostUrl => imageUrlPost!;

  String get getFileName => fileName!;

  Uint8List get getFilebytes => pickedFileBytess;

  PickedFile get getPickImageGallery => pickedImage!;

  File get getImageGallery => imageGallery!;

  bool get getIsNotEmptyImage => isNotEmptyImage!;

  createPost(
      String userName, String email,PostModel postModel, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection("table-post")
          .add(postModel.toMap())
          .then((value) {

        DocumentReference documentReference = FirebaseFirestore
            .instance
            .collection("table-like")
            .doc(value.id)
            .collection(value.id)
            .doc(value.id);

        FirebaseFirestore.instance
            .runTransaction((transaction) async {
          transaction.set(
            documentReference,
            {
              "postId": value.id,
              "like": false,
              "commentCount" : 0,
              "likeCount" : 0,
              "emailSaNagLike": "",
              "firstName": "",
            },
          );
        }).whenComplete(() async {});


        Fluttertoast.showToast(
          msg: "Post created successfully :) ",
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.CENTER_RIGHT,
        );

        Navigator.pop(context);

        notifyListeners();
      });
    } catch (e) {}
  }
}
