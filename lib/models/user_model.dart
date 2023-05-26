class UserModel {
  int id;
  String email;
  String password;

  UserModel({required this.id, required this.email, required this.password});

  static Map<String, dynamic> toMap(UserModel user) {
    return {
      'id': user.id,
      'email': user.email,
      'password': user.password,
    };
  }
}
