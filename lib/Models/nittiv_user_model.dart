import '../Core/Utils/nittiv-user-type.dart';
import '../Entities/nittiv_user.dart';

class NittivUserModel extends NittivUser {
  const NittivUserModel({
    required super.username,
    required super.email,
    required super.uid,
    required super.userType,
  });

  NittivUserModel copyWith({
    NittivUserType? userType,
    String? username,
    String? email,
    String? uid,
  }) {
    return NittivUserModel(
      userType: userType ?? this.userType,
      username: username ?? this.username,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }
}
