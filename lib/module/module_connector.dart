import 'package:async_redux/async_redux.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:coordenador/teacher/teacher_action.dart';
import 'package:flutter/material.dart';

import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/course_action.dart';
import 'package:coordenador/module/module_action.dart';
import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/module/module_page.dart';

class ModuleConnector extends StatelessWidget {
  final String courseId;
  const ModuleConnector({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleViewModel>(
      onInit: (store) {
        store.dispatch(SetCourseCurrentCourseAction(id: courseId));
        // store.dispatch(ReadDocsModuleAction());
        store.dispatch(ReadDocsTeacherAction());
      },
      vm: () => ModuleFactory(this),
      builder: (context, vm) => ModulePage(
        courseModel: vm.courseModel,
        moduleModelList: [],
      ),
    );
  }
}

class ModuleFactory extends VmFactory<AppState, ModuleConnector> {
  ModuleFactory(widget) : super(widget);
  ModuleViewModel fromStore() => ModuleViewModel(
        courseModel: state.courseState.courseModelCurrent!,
        moduleModelList: [],
      );
}

class ModuleViewModel extends Vm {
  final CourseModel courseModel;
  final List<ModuleModel> moduleModelList;
  ModuleViewModel({
    required this.moduleModelList,
    required this.courseModel,
  }) : super(equals: [
          moduleModelList,
        ]);
}
