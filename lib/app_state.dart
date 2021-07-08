import 'package:async_redux/async_redux.dart';
import 'package:coordenador/course/course_state.dart';
import 'package:coordenador/login/login_state.dart';
import 'package:coordenador/module/module_state.dart';
import 'package:coordenador/upload/upload_state.dart';
import 'package:coordenador/teacher/teacher_state.dart';
import 'package:coordenador/user/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final TeacherState teacherState;
  final UploadState uploadState;
  final CourseState courseState;
  final ModuleState moduleState;
  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.teacherState,
    required this.uploadState,
    required this.courseState,
    required this.moduleState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        teacherState: TeacherState.initialState(),
        uploadState: UploadState.initialState(),
        courseState: CourseState.initialState(),
        moduleState: ModuleState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    TeacherState? teacherState,
    UploadState? uploadState,
    CourseState? courseState,
    ModuleState? moduleState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      teacherState: teacherState ?? this.teacherState,
      uploadState: uploadState ?? this.uploadState,
      courseState: courseState ?? this.courseState,
      moduleState: moduleState ?? this.moduleState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.moduleState == moduleState &&
        other.courseState == courseState &&
        other.uploadState == uploadState &&
        other.loginState == loginState &&
        other.teacherState == teacherState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return courseState.hashCode ^
        moduleState.hashCode ^
        uploadState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        teacherState.hashCode ^
        wait.hashCode;
  }
}
