import 'dart:convert';

import 'owner.dart';

class CommentModel {
  String? id;
  String? message;
  Owner? owner;
  String? post;
  DateTime? publishDate;

  CommentModel({
    this.id,
    this.message,
    this.owner,
    this.post,
    this.publishDate,
  });

  factory CommentModel.fromMap(
      Map<String, dynamic> data) {
    return CommentModel(
      id: data['id'] as String?,
      message: data['message'] as String?,
      owner: data['owner'] == null
          ? null
          : Owner
              .fromMap(
                  data['owner'] as Map<String, dynamic>),
      post: data['post'] as String?,
      publishDate: data['publishDate'] == null
          ? null
          : DateTime.parse(data['publishDate'] as String),
    );
  }

  Map<String, dynamic>
      toMap() {
    return {
      'id': id,
      'message': message,
      'owner': owner
          ?.toMap(),
      'post': post,
      'publishDate': publishDate?.toIso8601String(),
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CommentModel].
  factory CommentModel.fromJson(String data) {
    return CommentModel
        .fromMap(
            json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CommentModel] to a JSON string.
  String toJson() => json.encode(
      toMap());
}
