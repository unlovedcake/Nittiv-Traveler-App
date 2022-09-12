class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? userType;
  String? imageUrl;

  List<bool> isShowTextField = [];

  UserModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.userType,
      this.imageUrl});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(

      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      userType: map['userType'],
      imageUrl: map['imageUrl'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {

      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'userType': userType,
      'imageUrl': imageUrl,
    };
  }
}
