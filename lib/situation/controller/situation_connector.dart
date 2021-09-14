import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/controller/course_model.dart';
import 'package:coordenador/module/controller/module_action.dart';
import 'package:coordenador/module/controller/module_model.dart';
import 'package:coordenador/situation/controller/situation_action.dart';
import 'package:coordenador/situation/controller/situation_model.dart';
import 'package:coordenador/situation/situation_page.dart';
import 'package:coordenador/user/controller/user_model.dart';

class SituationConnector extends StatelessWidget {
  final String moduleId;
  const SituationConnector({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SituationViewModel>(
      onInit: (store) async {
        await store.dispatch(SetModuleCurrentModuleAction(id: moduleId));
        store.dispatch(StreamDocsSituationAction());
      },
      vm: () => SituationFactory(this),
      builder: (context, vm) => SituationPage(
        teacher: vm.teacher,
        courseModel: vm.courseModel,
        moduleModel: vm.moduleModel,
        situationList: vm.situationList,
        onChangeSituationOrder: vm.onChangeSituationOrder,
      ),
    );
  }
}

class SituationFactory extends VmFactory<AppState, SituationConnector> {
  SituationFactory(widget) : super(widget);
  SituationViewModel fromStore() => SituationViewModel(
        teacher: state.teacherState.teacherCurrent,
        // coordinator: state.coordinatorState.coordinatorCurrent,
        courseModel: state.courseState.courseModelCurrent,
        moduleModel: state.moduleState.moduleModelCurrent!,
        situationList: state.situationState.situationList!,
        onChangeSituationOrder: (List<String> situationOrder) {
          ModuleModel moduleModel = state.moduleState.moduleModelCurrent!;
          moduleModel = moduleModel.copyWith(situationOrder: situationOrder);
          dispatch(UpdateDocModuleAction(moduleModel: moduleModel));
        },
      );
}

class SituationViewModel extends Vm {
  // final UserModel? coordinator;
  final CourseModel? courseModel;
  final ModuleModel moduleModel;
  final List<SituationModel> situationList;
  final Function(List<String>) onChangeSituationOrder;
  final UserModel? teacher;

  SituationViewModel({
    required this.teacher,
    required this.courseModel,
    required this.moduleModel,
    required this.situationList,
    required this.onChangeSituationOrder,
  }) : super(equals: [
          teacher,
          courseModel,
          moduleModel,
          situationList,
        ]);
}
