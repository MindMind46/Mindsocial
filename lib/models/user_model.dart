import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {

  final String email;
  final String name;
  final String password;
  final String urlAvatar;
  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.urlAvatar,
  }); 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
      'urlAvatar': urlAvatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      urlAvatar: map['urlAvatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
