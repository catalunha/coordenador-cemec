import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/course_action.dart';
import 'package:coordenador/course/course_addedit_page.dart';
import 'package:coordenador/upload/upload_action.dart';
import 'package:flutter/cupertino.dart';

import 'package:coordenador/course/course_model.dart';

class CourseAddEditConnector extends StatelessWidget {
  final String addOrEditId;
  const CourseAddEditConnector({Key? key, required this.addOrEditId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CourseAddEditViewModel>(
      onInit: (store) {
        store.dispatch(RestartingStateUploadAction());
        store.dispatch(SetCourseCurrentCourseAction(id: addOrEditId));
        if (addOrEditId.isNotEmpty &&
            store.state.courseState.courseModelCurrent!.iconUrl != null) {
          store.dispatch(SetUrlForDownloadUploadAction(
              url: store.state.courseState.courseModelCurrent!.iconUrl!));
        }
      },
      onDispose: (store) => store.dispatch(ReadDocsCourseAction()),
      vm: () => CourseAddEditFactory(this),
      builder: (context, vm) => CourseAddEditPage(
        formController: vm.formController,
        onSave: vm.onSave,
      ),
    );
  }
}

class CourseAddEditFactory extends VmFactory<AppState, CourseAddEditConnector> {
  CourseAddEditFactory(widget) : super(widget);
  @override
  CourseAddEditViewModel fromStore() => CourseAddEditViewModel(
        formController:
            FormController(courseModel: state.courseState.courseModelCurrent!),
        onSave: (CourseModel courseModel) {
          print(state.userState.userCurrent!.id);
          print(courseModel);
          courseModel = courseModel.copyWith(
              coordinatorUserId: state.userState.userCurrent!.id);
          if (state.uploadState.urlForDownload != null &&
              state.uploadState.urlForDownload!.isNotEmpty) {
            courseModel =
                courseModel.copyWith(iconUrl: state.uploadState.urlForDownload);
          }
          print(courseModel);
          if (widget!.addOrEditId.isEmpty) {
            dispatch(CreateDocCourseAction(courseModel: courseModel));
          } else {
            dispatch(UpdateDocCourseAction(courseModel: courseModel));
          }
        },
      );
}

class CourseAddEditViewModel extends Vm {
  // final CourseModel courseModel;
  final FormController formController;
  final Function(CourseModel) onSave;
  CourseAddEditViewModel({
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
  CourseModel courseModel;
  FormController({
    required this.courseModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? title,
    String? description,
    String? syllabus,
  }) {
    courseModel = courseModel.copyWith(
      title: title,
      description: description,
      syllabus: syllabus,
    );
    print('==--> FormController.onChange: $courseModel');
  }

  void onCkechValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
