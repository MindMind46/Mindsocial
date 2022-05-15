// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String namePost;
  final String postBody;
  final Timestamp timePost;
  final String uidPost;
  final String urlAvatarPost;
  PostModel({
    required this.namePost,
    required this.postBody,
    required this.timePost,
    required this.uidPost,
    required this.urlAvatarPost,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'namePost': namePost,
      'postBody': postBody,
      'timePost': timePost,
      'uidPost': uidPost,
      'urlAvatarPost': urlAvatarPost,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      namePost: map['namePost'] as String,
      postBody: map['postBody'] as String,
      timePost: (map['timePost']),
      uidPost: map['uidPost'] as String,
      urlAvatarPost: map['urlAvatarPost'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
