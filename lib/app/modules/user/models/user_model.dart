import 'dart:convert';

class UserModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  UserModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] as String?,
      title: data['title'] as String?,
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      picture: data['picture'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
