import 'package:coordenador/app_state.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:flutter/foundation.dart';

class TeacherState {
  final UserModel? teacherCurrent;
  final List<UserModel>? teacherList;
  static UserModel? selectTeacher(AppState state, String teacherId) =>
      state.teacherState.teacherList!
          .firstWhere((element) => element.id == teacherId, orElse: null);
  TeacherState({
    this.teacherCurrent,
    this.teacherList,
  });
  factory TeacherState.initialState() => TeacherState(
        teacherCurrent: null,
        teacherList: [],
      );
  // TeacherState resetTeacherCurrent() => TeacherState(
  //       teacherCurrent: null,
  //       teacherList: this.teacherList,
  //     );
  TeacherState copyWith({
    UserModel? teacherCurrent,
    List<UserModel>? teacherList,
  }) {
    return TeacherState(
      teacherCurrent: teacherCurrent, // ?? this.teacherCurrent,
      teacherList: teacherList ?? this.teacherList,
    );
  }

  @override
  String toString() =>
      'TeacherState(teacherCurrent: $teacherCurrent, teacherList: $teacherList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeacherState &&
        other.teacherCurrent == teacherCurrent &&
        listEquals(other.teacherList, teacherList);
  }

  @override
  int get hashCode => teacherCurrent.hashCode ^ teacherList.hashCode;
}
