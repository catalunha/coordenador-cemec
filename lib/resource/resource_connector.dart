import 'package:async_redux/async_redux.dart';
import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/module/module_action.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:coordenador/resource/resource_action.dart';
import 'package:coordenador/resource/resource_model.dart';
import 'package:coordenador/resource/resource_page.dart';
import 'package:coordenador/teacher/teacher_action.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:flutter/material.dart';

import 'package:coordenador/app_state.dart';

class ResourceConnector extends StatelessWidget {
  final String moduleId;
  const ResourceConnector({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ResourceViewModel>(
      onInit: (store) async {
        await store.dispatch(SetModuleCurrentModuleAction(id: moduleId));
        if (store.state.moduleState.moduleModelCurrent!.teacherUserId != null) {
          store.dispatch(SetTeacherCurrentTeacherAction(
              id: store.state.moduleState.moduleModelCurrent!.teacherUserId!));
        } else {
          store.dispatch(RestartingStateTeacherAction());
        }
        store.dispatch(ReadDocsResourceAction());
      },
      vm: () => ResourceFactory(this),
      builder: (context, vm) => ResourcePage(
        courseModel: vm.courseModel,
        moduleModel: vm.moduleModel,
        resourceModelList: vm.resourceModelList,
        teacher: vm.teacher,
      ),
    );
  }
}

class ResourceFactory extends VmFactory<AppState, ResourceConnector> {
  ResourceFactory(widget) : super(widget);
  ResourceViewModel fromStore() => ResourceViewModel(
        courseModel: state.courseState.courseModelCurrent!,
        moduleModel: state.moduleState.moduleModelCurrent!,
        resourceModelList: state.resourceState.resourceModelList!,
        teacher: state.teacherState.teacherCurrent,
      );
}

class ResourceViewModel extends Vm {
  final CourseModel courseModel;
  final ModuleModel moduleModel;
  final List<ResourceModel> resourceModelList;
  final UserModel? teacher;

  ResourceViewModel({
    required this.resourceModelList,
    required this.courseModel,
    required this.moduleModel,
    this.teacher,
  }) : super(equals: [
          resourceModelList,
          courseModel,
          moduleModel,
        ]);
}
