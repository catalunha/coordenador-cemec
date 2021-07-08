import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:coordenador/firestore/firestore_model.dart';

class ModuleModel extends FirestoreModel {
  static final String collection = 'courses';

  final String courseId;
  final String title;
  final String description;
  final String syllabus;
  final String teacherUserId; // User.id
  final bool isArchivedByProf; //for prof use
  final List<String>? resourceOrder;
  ModuleModel(
    String id, {
    required this.courseId,
    required this.title,
    required this.description,
    required this.syllabus,
    required this.teacherUserId,
    required this.isArchivedByProf,
    this.resourceOrder,
  }) : super(id);

  ModuleModel copyWith({
    String? courseId,
    String? title,
    String? description,
    String? syllabus,
    String? teacherUserId,
    bool? isArchivedByProf,
    List<String>? resourceOrder,
  }) {
    return ModuleModel(
      this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      syllabus: syllabus ?? this.syllabus,
      teacherUserId: teacherUserId ?? this.teacherUserId,
      isArchivedByProf: isArchivedByProf ?? this.isArchivedByProf,
      resourceOrder: resourceOrder ?? this.resourceOrder,
    );
  }

  factory ModuleModel.fromMap(String id, Map<String, dynamic> map) {
    return ModuleModel(
      id,
      courseId: map['courseId'],
      title: map['title'],
      description: map['description'],
      syllabus: map['syllabus'],
      teacherUserId: map['teacherUserId'],
      isArchivedByProf: map['isArchivedByProf'],
      resourceOrder: map['resourceOrder'] == null
          ? []
          : List<String>.from(map['resourceOrder']),
    );
  }
  factory ModuleModel.fromJson(String id, String source) =>
      ModuleModel.fromMap(id, json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'title': title,
      'description': description,
      'syllabus': syllabus,
      'teacherUserId': teacherUserId,
      'isArchivedByProf': isArchivedByProf,
      'resourceOrder': resourceOrder,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ModuleModel(courseId: $courseId, title: $title, description: $description, syllabus: $syllabus, teacherUserId: $teacherUserId, isArchivedByProf: $isArchivedByProf, resourceOrder: $resourceOrder)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModuleModel &&
        other.courseId == courseId &&
        other.title == title &&
        other.description == description &&
        other.syllabus == syllabus &&
        other.teacherUserId == teacherUserId &&
        other.isArchivedByProf == isArchivedByProf &&
        listEquals(other.resourceOrder, resourceOrder);
  }

  @override
  int get hashCode {
    return courseId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        syllabus.hashCode ^
        teacherUserId.hashCode ^
        isArchivedByProf.hashCode ^
        resourceOrder.hashCode;
  }
}
