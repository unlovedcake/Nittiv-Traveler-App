import '../Core/Utils/nittiv-user-type.dart';
import '../Entities/nittiv_user.dart';
import '../Pages/Register-Page/widgets/operator_registration_form.dart';

class OperatorUserModel extends OperatorUser {
  const OperatorUserModel({
    required super.businessName,
    required super.businessCategory,
    required super.socialLink,
    required super.userType,
    required super.username,
    required super.email,
    required super.uid,
  });

  factory OperatorUserModel.fromMap(Map<String, dynamic> map) {
    return OperatorUserModel(
      businessName: map['business_name'] as String? ?? '',
      businessCategory: BusinessCategory(
        name: map['business_category'] as String? ?? '',
      ),
      socialLink: map['social_link'] as String? ?? '',
      userType: NittivUserType.operator,
      username: map['username'] as String? ?? '',
      email: map['email'] as String? ?? '',
      uid: map['uid'] as String? ?? '',
    );
  }
}
