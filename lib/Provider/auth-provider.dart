import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../Core/Router/routesname.dart';
import '../Core/Utils/nittiv-user-type.dart';
import '../Core/Widgets/progress-dialog.dart';
import '../Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;

  String? errorMessage;
  String? userEmail;

  bool operator = false;

  NittivUserType _userType = NittivUserType.traveler;

  int currentIndex = 0;

  String get getUserEmail => userEmail!;

  setNabvarIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  int get getNabvarIndex => currentIndex;

  userType(NittivUserType userType) {
    _userType = userType;
    notifyListeners();
  }

  setOperatorOrTraveler(bool isOperator) {
    operator = isOperator;
    notifyListeners();
  }

  bool get getOperatorOrTraveler => operator;

  NittivUserType get getUserType => _userType;

  signUp(String password, UserModel? userModel, BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Authenticating, Please wait...",
            );
          });

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userModel!.email.toString(), password: password);
      user = userCredential.user;

      await user!.updateDisplayName(userModel.userType.toString());
      await user!.reload();
      user = _auth.currentUser;

      userModel.imageUrl =
          "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png";

      await FirebaseFirestore.instance
          .collection("table-user")
          .doc(user!.uid)
          .set(userModel.toMap())
          .whenComplete(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', userModel.email.toString());

        userEmail = userModel.email.toString();

        Fluttertoast.showToast(
          msg: "Account created successfully :) ",
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.CENTER_RIGHT,
        );

        notifyListeners();
      });

      Navigator.of(context).pop();

      Navigator.of(context).pushNamed(
        RoutesName.HOME_URL,
      );
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "email-already-in-use":
          errorMessage = "The account already exists for that email.";
          break;

        case "weak-password":
          errorMessage = "Weak Password.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "Check Your Internet Access.";
      }

      Fluttertoast.showToast(
        timeInSecForIosWeb: 3,
        msg: errorMessage!,
        gravity: ToastGravity.CENTER,
      );
      print(error.code);
    }
  }

  signIn(String email, String password, BuildContext context) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Authenticating, Please wait...",
            );
          });

      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async {
        Navigator.of(context).pushNamed(
          RoutesName.HOME_URL,
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email);
        notifyListeners();

        // Fluttertoast.showToast(
        //   msg: "You are now logged in... :) ",
        //   timeInSecForIosWeb: 3,
        //   gravity: ToastGravity.CENTER_RIGHT,
        // );

        //Navigator.of(context).pop();
        QuickAlert.show(
          width: 500,
          //customAsset: 'assets/images/form-header-img.png',
          context: context,
          autoCloseDuration: const Duration(seconds: 3),
          type: QuickAlertType.loading,
          text: 'Welcome, You are now logged in !!!',
        );
      });
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be invalid.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "Check Your Internet Access.";
      }

      QuickAlert.show(
        context: context,
        autoCloseDuration: const Duration(seconds: 3),
        type: QuickAlertType.error,
        title: 'Oops...',
        text: errorMessage!,
      );
      // Fluttertoast.showToast(
      //   msg: errorMessage!,
      //   timeInSecForIosWeb: 3,
      //   gravity: ToastGravity.CENTER_RIGHT,
      // );
      print(error.code);
    }
  }

  static Future<void> logout(BuildContext context) async {
    QuickAlert.show(
      width: 500,
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to logout',
      confirmBtnText: 'Yes',
      onConfirmBtnTap: () async {
        await FirebaseAuth.instance.signOut();

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');

        Navigator.of(context).pushNamed(RoutesName.LOGIN_URL);
      },
      cancelBtnText: 'No',
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
      cancelBtnTextStyle: TextStyle(color: Colors.red),
      confirmBtnColor: Colors.green,
    );
  }

  // Stream<QuerySnapshot> loggedInUserInfo() {
  //   return FirebaseFirestore.instance
  //       .collection("table-user")
  //       .where('email', isEqualTo: user!.email)
  //       .snapshots();
  // }

  Stream<QuerySnapshot> displayPost() {
    return FirebaseFirestore.instance
        .collection("table-post")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .snapshots();
  }
}
