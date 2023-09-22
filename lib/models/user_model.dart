import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String skill;
  final int workExpreince;
  final String? imagePath;

  UserModel(
    this.name,
    this.email,
    this.skill,
    this.workExpreince,
    this.imagePath,
  );

  UserModel copyWith({
    String? name,
    String? email,
    String? skill,
    int? workExpreince,
    String? imagePath,
  }) {
    return UserModel(
      name ?? this.name,
      email ?? this.email,
      skill ?? this.skill,
      workExpreince ?? this.workExpreince,
      imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'skill': skill,
      'workExpreince': workExpreince,
      'imagePath': imagePath,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'] ?? '',
      map['email'] ?? '',
      map['skill'] ?? '',
      map['workExpreince']?.toInt() ?? 0,
      map['imagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, skill: $skill, workExpreince: $workExpreince, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.skill == skill &&
        other.workExpreince == workExpreince &&
        other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ skill.hashCode ^ workExpreince.hashCode ^ imagePath.hashCode;
  }

  factory UserModel.defaultValue() => UserModel('Developer', 'dev@gmail.com', 'Flutter,Dart,Android,java', 5, null);
}
