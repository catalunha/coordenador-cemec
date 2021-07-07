import 'dart:convert';

import 'package:coordenador/firestore/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'users';
  final String? displayName;
  final String email;
  final String? phoneNumber;
  final String? photoURL;

  UserModel(
    String id, {
    this.displayName,
    required this.email,
    this.phoneNumber,
    this.photoURL,
  }) : super(id);

  UserModel copyWith({
    String? displayName,
    String? email,
    String? phoneNumber,
    String? photoURL,
  }) {
    return UserModel(
      id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id,
      displayName: map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      photoURL: map['photoURL'],
    );
  }

  factory UserModel.fromJson(String id, String source) =>
      UserModel.fromMap(id, json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(displayName: $displayName, email: $email, phoneNumber: $phoneNumber, photoURL: $photoURL)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.displayName == displayName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        photoURL.hashCode;
  }
}
