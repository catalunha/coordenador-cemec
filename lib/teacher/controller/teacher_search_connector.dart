import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/teacher/controller/teacher_action.dart';
import 'package:coordenador/teacher/teacher_search.dart';
import 'package:coordenador/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class TeacherSearchConnector extends StatelessWidget {
  final String label;

  const TeacherSearchConnector({Key? key, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeacherSearchViewModel>(
      vm: () => TeacherSearchFactory(this),
      builder: (context, vm) => TeacherSearch(
        label: label,
        teacher: vm.teacher,
        onDeleteTeacher: vm.onDeleteTeacher,
      ),
    );
  }
}

class TeacherSearchFactory extends VmFactory<AppState, TeacherSearchConnector> {
  TeacherSearchFactory(widget) : super(widget);
  @override
  TeacherSearchViewModel fromStore() => TeacherSearchViewModel(
        teacher: state.teacherState.teacherCurrent,
        onDeleteTeacher: () {
          dispatch(SetTeacherCurrentTeacherAction(id: null));
        },
      );
}

class TeacherSearchViewModel extends Vm {
  final UserModel? teacher;
  final VoidCallback onDeleteTeacher;
  TeacherSearchViewModel({
    required this.teacher,
    required this.onDeleteTeacher,
  }) : super(equals: [
          teacher,
        ]);
}
