// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../Core/Utils/nittiv-user-type.dart';
import '../Pages/Register-Page/widgets/operator_registration_form.dart';

abstract class NittivUser extends Equatable {
  final NittivUserType userType;
  final String username;
  final String email;
  final String uid;
  const NittivUser({
    required this.userType,
    required this.username,
    required this.email,
    required this.uid,
  });

  @override
  List<Object> get props => [userType, username, email, uid];
}

class TravelerUser extends NittivUser {
  final String firstName;
  final String lastName;
  const TravelerUser({
    required this.firstName,
    required this.lastName,
    required super.userType,
    required super.username,
    required super.email,
    required super.uid,
  });
}

class OperatorUser extends NittivUser {
  final String businessName;
  final BusinessCategory businessCategory;
  final String socialLink;
  const OperatorUser({
    required this.businessName,
    required this.businessCategory,
    required this.socialLink,
    required super.userType,
    required super.username,
    required super.email,
    required super.uid,
  });
}
