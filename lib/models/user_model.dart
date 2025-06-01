class UserModel {
  final String uid;
  final String username;
  final String university;
  final String major;

  UserModel({
    required this.uid,
    required this.username,
    required this.university,
    required this.major,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      university: json['university'] ?? '',
      major: json['major'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'username': username,
    'university': university,
    'major': major,
  };
}