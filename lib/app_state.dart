import 'package:async_redux/async_redux.dart';
import 'package:coordenador/course/course_state.dart';
import 'package:coordenador/login/login_state.dart';
import 'package:coordenador/upload/upload_state.dart';
import 'package:coordenador/user/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final UploadState uploadState;
  final CourseState courseState;
  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.uploadState,
    required this.courseState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        uploadState: UploadState.initialState(),
        courseState: CourseState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    UploadState? uploadState,
    CourseState? courseState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      uploadState: uploadState ?? this.uploadState,
      courseState: courseState ?? this.courseState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.courseState == courseState &&
        other.uploadState == uploadState &&
        other.loginState == loginState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return courseState.hashCode ^
        uploadState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
