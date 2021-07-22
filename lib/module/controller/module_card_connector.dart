import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/module/module_card.dart';
import 'package:coordenador/module/controller/module_model.dart';
import 'package:coordenador/teacher/controller/teacher_state.dart';
import 'package:coordenador/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class ModuleCardConnector extends StatelessWidget {
  final ModuleModel moduleModel;

  const ModuleCardConnector({Key? key, required this.moduleModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleCardViewModel>(
      vm: () => ModuleCardFactory(this),
      builder: (context, vm) => ModuleCard(
        moduleModel: moduleModel,
        teacher: vm.teacher,
      ),
    );
  }
}

class ModuleCardFactory extends VmFactory<AppState, ModuleCardConnector> {
  ModuleCardFactory(widget) : super(widget);
  @override
  ModuleCardViewModel fromStore() => ModuleCardViewModel(
        teacher: selectTeacher(),
      );

  selectTeacher() {
    if (widget!.moduleModel.teacherUserId != null) {
      UserModel? temp =
          TeacherState.selectTeacher(state, widget!.moduleModel.teacherUserId!);
      return temp;
    }
    return null;
  }
}

class ModuleCardViewModel extends Vm {
  final UserModel? teacher;
  ModuleCardViewModel({
    required this.teacher,
  }) : super(equals: [
          teacher,
        ]);
}
