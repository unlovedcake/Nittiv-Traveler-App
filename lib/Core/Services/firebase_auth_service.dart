import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Entities/nittiv_user.dart';
import '../../Pages/Register-Page/widgets/operator_registration_form.dart';
import '../Exceptions/nittiv_exceptions.dart';
import '../Utils/nittiv-user-type.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  final GoogleSignIn _googleSignInInstance = GoogleSignIn();
  final EmailAuth _emailAuth = EmailAuth(sessionName: 'Nittiv');

  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;
  Future<NittivUser> googleSignIn(NittivUserType userType) async {
    try {
      final GoogleSignInAccount? user = await _googleSignInInstance.signIn();
      final GoogleSignInAuthentication? auth = await user?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: auth?.accessToken,
        idToken: auth?.idToken,
      );

      await _firebaseAuthInstance.signInWithCredential(credentials);

      var result;
      NittivUserType _userType = userType;
      try {
        result = await _firestoreInstance
            .collection('/users')
            .doc(_firebaseAuthInstance.currentUser!.uid)
            .get();

        _userType = result['user_type'] == NittivUserType.traveler.name
            ? NittivUserType.traveler
            : NittivUserType.operator;
      } catch (e) {
        log(e.toString());
        result = userType == NittivUserType.traveler
            ? {
                'user_type': userType.name,
                'username': _firebaseAuthInstance.currentUser!.displayName!,
                'first_name': null,
                'last_name': null,
              }
            : {
                'user_type': userType.name,
                'username': null,
                'business_name':
                    _firebaseAuthInstance.currentUser!.displayName!,
                'business_category': null,
                'social_link': null,
              };
        await _firestoreInstance
            .collection('/users')
            .doc(_firebaseAuthInstance.currentUser!.uid)
            .set(result);
      }
      return _userType == NittivUserType.traveler
          ? TravelerUser(
              firstName: result['first_name'] ?? '',
              lastName: result['last_name'] ?? '',
              userType: userType,
              username: result['username'] ?? '',
              email: _firebaseAuthInstance.currentUser!.email!,
              uid: _firebaseAuthInstance.currentUser!.uid,
            )
          : OperatorUser(
              businessName: result['business_name'] ?? '',
              businessCategory: BusinessCategory(
                name: result['business_category'] ?? '',
              ),
              socialLink: result['social_link'] ?? '',
              userType: userType,
              username: result['username'] ?? '',
              email: _firebaseAuthInstance.currentUser!.email!,
              uid: _firebaseAuthInstance.currentUser!.uid,
            );
    } catch (e) {
      log(e.toString());
      throw const NittivAuthException(message: 'Google Sign In Failed');
    }
  }

  Future<NittivUser> login(String email, String password) async {
    try {
      await _firebaseAuthInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = await _firestoreInstance
          .collection('/users')
          .doc(_firebaseAuthInstance.currentUser!.uid)
          .get();

      return result['user_type'] == NittivUserType.traveler.name
          ? TravelerUser(
              userType: NittivUserType.traveler,
              username: result['username'],
              email: email,
              uid: _firebaseAuthInstance.currentUser!.uid,
              firstName: result['first_name'],
              lastName: result['last_name'],
            )
          : OperatorUser(
              businessName: result['business_name'],
              businessCategory: BusinessCategory(
                name: result['business_category'],
              ),
              socialLink: result['social_link'],
              userType: NittivUserType.operator,
              username: result['username'],
              email: email,
              uid: _firebaseAuthInstance.currentUser!.uid,
            );
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        throw const NittivAuthException(
            message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw const NittivAuthException(
            message: 'Wrong password provided for that user.');
      }
    }
    throw const NittivAuthException(
      message: "Invalid Credentials",
    );
  }

  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  Future<NittivUser> register(
      NittivUserType userType,
      String name,
      String? lastName,
      String email,
      String? username,
      String? socialLink,
      BusinessCategory? businessCategory,
      String? otp,
      String? password) async {
    try {
      await _firebaseAuthInstance.createUserWithEmailAndPassword(
          email: email, password: password!);

      final result = userType == NittivUserType.traveler
          ? {
              'user_type': userType.name,
              'username': username,
              'first_name': name,
              'last_name': lastName,
            }
          : {
              'user_type': userType.name,
              'username': username,
              'business_name': name,
              'business_category': businessCategory!.name,
              'social_link': socialLink,
            };
      await _firestoreInstance
          .collection('/users')
          .doc(_firebaseAuthInstance.currentUser!.uid)
          .set(result);

      return userType == NittivUserType.traveler
          ? TravelerUser(
              userType: NittivUserType.traveler,
              username: username!,
              email: email,
              uid: _firebaseAuthInstance.currentUser!.uid,
              firstName: name,
              lastName: lastName!,
            )
          : OperatorUser(
              businessName: name,
              businessCategory: businessCategory!,
              socialLink: socialLink!,
              userType: NittivUserType.operator,
              username: username!,
              email: email,
              uid: _firebaseAuthInstance.currentUser!.uid,
            );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const NittivAuthException(
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw const NittivAuthException(
            message: 'The account already exists for that email.');
      }
    }
    throw const NittivAuthException(
      message: "Invalid Credentials",
    );
  }

  Future<void> sendOTP(String email) async {
    try {
      final result =
          await _emailAuth.sendOtp(recipientMail: email, otpLength: 6);
      if (!result) {
        throw const NittivAuthException(message: "Unable to send OTP");
      }
    } catch (e) {
      if (e is NittivAuthException) rethrow;
      throw const NittivAuthException(message: 'Server Error');
    }
  }

  Future<void> validateOTP(String email, String otp) async {
    try {
      final result = _emailAuth.validateOtp(
        recipientMail: email,
        userOtp: otp,
      );
      if (!result) {
        throw const NittivAuthException(message: "Invalid OTP");
      }
    } catch (e) {
      throw const NittivAuthException(message: "Invalid OTP");
    }
  }

  Future<void> validateUsername(String username) async {
    try {
      final result = await _firestoreInstance
          .collection('/users')
          .where(
            'username',
            isEqualTo: username,
          )
          .get();
      if (result.docs.isNotEmpty) {
        throw NittivAuthException(message: '$username already exists');
      }
    } catch (e) {
      log(e.toString());
      if (e is NittivAuthException) rethrow;
      throw const NittivAuthException(message: 'Server Error');
    }
  }

  Future<NittivUser> fetchUser(String uid) async {
    try {
      final result =
          await _firestoreInstance.collection('/users').doc(uid).get();

      return result['user_type'] == NittivUserType.traveler.name
          ? TravelerUser(
              userType: NittivUserType.traveler,
              username: result['username'],
              email: _firebaseAuthInstance.currentUser!.email!,
              uid: _firebaseAuthInstance.currentUser!.uid,
              firstName: result['first_name'],
              lastName: result['last_name'],
            )
          : OperatorUser(
              businessName: result['business_name'],
              businessCategory: BusinessCategory(
                name: result['business_category'],
              ),
              socialLink: result['social_link'],
              userType: NittivUserType.operator,
              username: result['username'],
              email: _firebaseAuthInstance.currentUser!.email!,
              uid: _firebaseAuthInstance.currentUser!.uid,
            );
    } catch (e) {
      throw const NittivAuthException(
        message: "You've been logged out!",
      );
    }
  }
}
