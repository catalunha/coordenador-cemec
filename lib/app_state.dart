import 'package:async_redux/async_redux.dart';
import 'package:coordenador/course/controller/course_state.dart';
import 'package:coordenador/login/controller/login_state.dart';
import 'package:coordenador/module/controller/module_state.dart';
import 'package:coordenador/resource/controller/resource_state.dart';
import 'package:coordenador/upload/controller/upload_state.dart';
import 'package:coordenador/teacher/controller/teacher_state.dart';
import 'package:coordenador/user/controller/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final TeacherState teacherState;
  final UploadState uploadState;
  final CourseState courseState;
  final ModuleState moduleState;
  final ResourceState resourceState;
  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.teacherState,
    required this.uploadState,
    required this.courseState,
    required this.moduleState,
    required this.resourceState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        teacherState: TeacherState.initialState(),
        uploadState: UploadState.initialState(),
        courseState: CourseState.initialState(),
        moduleState: ModuleState.initialState(),
        resourceState: ResourceState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    TeacherState? teacherState,
    UploadState? uploadState,
    CourseState? courseState,
    ModuleState? moduleState,
    ResourceState? resourceState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      teacherState: teacherState ?? this.teacherState,
      uploadState: uploadState ?? this.uploadState,
      courseState: courseState ?? this.courseState,
      moduleState: moduleState ?? this.moduleState,
      resourceState: resourceState ?? this.resourceState,
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
        other.resourceState == resourceState &&
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
        resourceState.hashCode ^
        wait.hashCode;
  }
}
