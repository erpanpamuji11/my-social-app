import 'dart:convert';

import 'owner.dart';

class PostUserModel {
  String? id;
  String? image;
  int? likes;
  List<dynamic>? tags;
  String? text;
  DateTime? publishDate;
  Owner? owner;
  bool? liked = false;

  PostUserModel({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
    this.liked,
  });

  factory PostUserModel.fromMap(Map<String, dynamic> data) {
    return PostUserModel(
      id: data['id'] as String?,
      image: data['image'] as String?,
      likes: data['likes'] as int?,
      tags: data['tags'] as List<dynamic>?,
      text: data['text'] as String?,
      publishDate: data['publishDate'] == null
          ? null
          : DateTime.parse(data['publishDate'] as String),
      owner: data['owner'] == null
          ? null
          : Owner.fromMap(data['owner'] as Map<String, dynamic>),
      liked: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'likes': likes,
      'tags': tags,
      'text': text,
      'publishDate': publishDate?.toIso8601String(),
      'owner': owner?.toMap(),
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PostUserModel].
  factory PostUserModel.fromJson(String data) {
    return PostUserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PostUserModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
