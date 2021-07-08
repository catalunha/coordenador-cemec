import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:coordenador/firestore/firestore_model.dart';

class CourseModel extends FirestoreModel {
  static final String collection = 'modules';

  final String coordinatorUserId; // User.id
  final String title;
  final String description;
  final String syllabus;
  final bool isArchivedByAdm; //for adm use
  final bool isArchivedByCoord; //for coord use

  final String? iconUrl;
  final List<String>? moduleOrder;
  CourseModel(
    String id, {
    required this.coordinatorUserId,
    required this.title,
    required this.description,
    required this.syllabus,
    this.iconUrl,
    required this.isArchivedByAdm,
    required this.isArchivedByCoord,
    this.moduleOrder,
  }) : super(id);

  CourseModel copyWith({
    String? coordinatorUserId,
    String? title,
    String? description,
    String? syllabus,
    String? iconUrl,
    bool? isArchivedByAdm,
    bool? isArchivedByCoord,
    List<String>? moduleOrder,
  }) {
    return CourseModel(
      this.id,
      coordinatorUserId: coordinatorUserId ?? this.coordinatorUserId,
      title: title ?? this.title,
      description: description ?? this.description,
      syllabus: syllabus ?? this.syllabus,
      iconUrl: iconUrl ?? this.iconUrl,
      isArchivedByAdm: isArchivedByAdm ?? this.isArchivedByAdm,
      isArchivedByCoord: isArchivedByCoord ?? this.isArchivedByCoord,
      moduleOrder: moduleOrder ?? this.moduleOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coordinatorUserId': coordinatorUserId,
      'title': title,
      'description': description,
      'syllabus': syllabus,
      'iconUrl': iconUrl,
      'isArchivedByAdm': isArchivedByAdm,
      'isArchivedByCoord': isArchivedByCoord,
      'moduleOrder': moduleOrder,
    };
  }

  factory CourseModel.fromMap(String id, Map<String, dynamic> map) {
    return CourseModel(
      id,
      coordinatorUserId: map['coordinatorUserId'],
      title: map['title'],
      description: map['description'],
      syllabus: map['syllabus'],
      iconUrl: map['iconUrl'],
      isArchivedByAdm: map['isArchivedByAdm'],
      isArchivedByCoord: map['isArchivedByCoord'],
      moduleOrder: map['moduleOrder'] == null
          ? []
          : List<String>.from(map['moduleOrder']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String id, String source) =>
      CourseModel.fromMap(id, json.decode(source));

  @override
  String toString() {
    return 'CourseModel(coordinatorUserId: $coordinatorUserId, title: $title, description: $description, syllabus: $syllabus, iconUrl: $iconUrl, isArchivedByAdm: $isArchivedByAdm, isArchivedByCoord: $isArchivedByCoord, moduleOrder: $moduleOrder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.coordinatorUserId == coordinatorUserId &&
        other.title == title &&
        other.description == description &&
        other.syllabus == syllabus &&
        other.iconUrl == iconUrl &&
        other.isArchivedByAdm == isArchivedByAdm &&
        other.isArchivedByCoord == isArchivedByCoord &&
        listEquals(other.moduleOrder, moduleOrder);
  }

  @override
  int get hashCode {
    return coordinatorUserId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        syllabus.hashCode ^
        iconUrl.hashCode ^
        isArchivedByAdm.hashCode ^
        isArchivedByCoord.hashCode ^
        moduleOrder.hashCode;
  }
}
