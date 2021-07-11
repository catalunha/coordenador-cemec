import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/module/module_action.dart';
import 'package:coordenador/module/module_addedit.page.dart';
import 'package:coordenador/module/module_model.dart';
import 'package:coordenador/teacher/teacher_action.dart';
import 'package:flutter/material.dart';

class ModuleAddEditConnector extends StatelessWidget {
  final String addOrEditId;
  const ModuleAddEditConnector({Key? key, required this.addOrEditId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleAddEditViewModel>(
      onInit: (store) {
        store.dispatch(SetModuleCurrentModuleAction(id: addOrEditId));
        // store.dispatch(RestartingStateTeacherAction());
        store.dispatch(SetTeacherCurrentTeacherAction(id: null));
        if (addOrEditId.isNotEmpty &&
            store.state.moduleState.moduleModelCurrent!.teacherUserId != null) {
          store.dispatch(SetTeacherCurrentTeacherAction(
              id: store.state.moduleState.moduleModelCurrent!.teacherUserId!));
        }
      },
      // onDispose: (store) => store.dispatch(ReadDocsModuleAction()),
      vm: () => ModuleAddEditFactory(this),
      builder: (context, vm) => ModuleAddEditPage(
        formController: vm.formController,
        onSave: vm.onSave,
      ),
    );
  }
}

class ModuleAddEditFactory extends VmFactory<AppState, ModuleAddEditConnector> {
  ModuleAddEditFactory(widget) : super(widget);
  @override
  ModuleAddEditViewModel fromStore() => ModuleAddEditViewModel(
        formController:
            FormController(moduleModel: state.moduleState.moduleModelCurrent!),
        onSave: (ModuleModel moduleModel) {
          print(moduleModel);
          moduleModel = moduleModel.copyWith(
              courseId: state.courseState.courseModelCurrent!.id);
          if (state.teacherState.teacherCurrent != null) {
            print(state.teacherState.teacherCurrent!.id);
            moduleModel = moduleModel.copyWith(
                teacherUserId: state.teacherState.teacherCurrent!.id);
          } else {
            moduleModel = moduleModel.copyWith(teacherUserIdNull: true);
          }
          if (widget!.addOrEditId.isEmpty) {
            dispatch(CreateDocModuleAction(moduleModel: moduleModel));
          } else {
            dispatch(UpdateDocModuleAction(moduleModel: moduleModel));
          }
        },
      );
}

class ModuleAddEditViewModel extends Vm {
  // final ModuleModel courseModel;
  final FormController formController;
  final Function(ModuleModel) onSave;
  ModuleAddEditViewModel({
    // required this.courseModel,
    required this.formController,
    required this.onSave,
  }) : super(equals: [
          // courseModel,
          formController,
        ]);
}

class FormController {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  ModuleModel moduleModel;
  FormController({
    required this.moduleModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? title,
    String? description,
    String? syllabus,
    bool? isDeleted,
  }) {
    moduleModel = moduleModel.copyWith(
      title: title,
      description: description,
      syllabus: syllabus,
      isDeleted: isDeleted,
    );
    print('==--> FormController.onChange: $moduleModel');
  }

  void onCkechValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
