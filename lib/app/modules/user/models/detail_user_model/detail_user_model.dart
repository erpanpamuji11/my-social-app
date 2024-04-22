import 'dart:convert';

import 'location.dart';

class DetailUserModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  DateTime? dateOfBirth;
  String? phone;
  Location? location;
  DateTime? registerDate;
  DateTime? updatedDate;

  DetailUserModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
  });

  factory DetailUserModel.fromMap(Map<String, dynamic> data) {
    return DetailUserModel(
      id: data['id'] as String?,
      title: data['title'] as String?,
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      picture: data['picture'] as String?,
      gender: data['gender'] as String?,
      email: data['email'] as String?,
      dateOfBirth: data['dateOfBirth'] == null
          ? null
          : DateTime.parse(data['dateOfBirth'] as String),
      phone: data['phone'] as String?,
      location: data['location'] == null
          ? null
          : Location.fromMap(data['location'] as Map<String, dynamic>),
      registerDate: data['registerDate'] == null
          ? null
          : DateTime.parse(data['registerDate'] as String),
      updatedDate: data['updatedDate'] == null
          ? null
          : DateTime.parse(data['updatedDate'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'picture': picture,
      'gender': gender,
      'email': email,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phone': phone,
      'location': location?.toMap(),
      'registerDate': registerDate?.toIso8601String(),
      'updatedDate': updatedDate?.toIso8601String(),
    };
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DetailUserModel].
  factory DetailUserModel.fromJson(String data) {
    return DetailUserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DetailUserModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
