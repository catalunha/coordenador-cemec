import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/course_action.dart';
import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/course/course_state.dart';
import 'package:coordenador/home/home_page.dart';
import 'package:coordenador/login/login_action.dart';

import 'package:flutter/material.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      // onInit: (store) => store.dispatch(ReadDocsCourseAction()),
      onInit: (store) => store.dispatch(StreamDocsCourseAction()),
      builder: (context, vm) => HomePage(
        signOut: vm.signOut,
        photoUrl: vm.photoUrl,
        phoneNumber: vm.phoneNumber,
        displayName: vm.displayName,
        uid: vm.uid,
        id: vm.id,
        email: vm.email,
        courseModelList: vm.courseModelList,
      ),
    );
  }
}

class HomeViewModelFactory extends VmFactory<AppState, HomePageConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        signOut: () => dispatch(SignOutLoginAction()),
        photoUrl: state.userState.userCurrent!.photoURL ?? '',
        phoneNumber: state.userState.userCurrent!.phoneNumber ?? '',
        displayName: state.userState.userCurrent!.displayName ?? '',
        email: state.userState.userCurrent!.email,
        uid: state.loginState.userFirebaseAuth?.uid ?? '',
        id: state.userState.userCurrent!.id,
        courseModelList: CourseState.selectCourseNotArchived(state),
      );
}

class HomeViewModel extends Vm {
  final VoidCallback signOut;

  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String email;
  final String uid;
  final String id;
  final List<CourseModel> courseModelList;
  HomeViewModel({
    required this.signOut,
    required this.photoUrl,
    required this.phoneNumber,
    required this.displayName,
    required this.email,
    required this.uid,
    required this.id,
    required this.courseModelList,
  }) : super(equals: [
          photoUrl,
          phoneNumber,
          displayName,
          email,
          uid,
          id,
          courseModelList,
        ]);
}
