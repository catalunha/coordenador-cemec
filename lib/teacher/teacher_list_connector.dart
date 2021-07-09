import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/teacher/teacher_action.dart';
import 'package:coordenador/teacher/teacher_list.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:flutter/material.dart';

class TeacherListConnector extends StatelessWidget {
  final String label;

  const TeacherListConnector({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeacherListViewModel>(
      vm: () => TeacherListFactory(this),
      builder: (context, vm) => TeacherList(
        label: label,
        teacherList: vm.teacherList,
        onSelect: vm.onSelect,
      ),
    );
  }
}

class TeacherListFactory extends VmFactory<AppState, TeacherListConnector> {
  TeacherListFactory(widget) : super(widget);
  @override
  TeacherListViewModel fromStore() => TeacherListViewModel(
        teacherList: state.teacherState.teacherList ?? [],
        onSelect: (String id) {
          dispatch(SetTeacherCurrentTeacherAction(id: id));
        },
      );
}

class TeacherListViewModel extends Vm {
  final List<UserModel> teacherList;
  final Function(String) onSelect;
  TeacherListViewModel({
    required this.teacherList,
    required this.onSelect,
  }) : super(equals: [
          teacherList,
        ]);
}
