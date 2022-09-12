import '../Core/Utils/nittiv-user-type.dart';
import '../Entities/nittiv_user.dart';

class TravelerUserModel extends TravelerUser {
  const TravelerUserModel({
    required super.firstName,
    required super.lastName,
    required super.userType,
    required super.username,
    required super.email,
    required super.uid,
  });

  factory TravelerUserModel.fromMap(Map<String, dynamic> map) {
    return TravelerUserModel(
      firstName: map['first_name'] as String? ?? '',
      lastName: map['last_name'] as String? ?? '',
      email: map['email'] as String ? ??'',
      uid: map['uid'] as String? ?? '',
      userType: NittivUserType.traveler,
      username: map['username'] as String? ??'' ,
    );
  }
}
