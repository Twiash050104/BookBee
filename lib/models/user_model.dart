class UserModel {
  final String uid;
  final String name;
  final String email;
  final String bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'bio': bio};
  }
}
