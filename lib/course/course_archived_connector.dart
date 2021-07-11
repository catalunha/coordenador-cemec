import 'package:async_redux/async_redux.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/course_action.dart';
import 'package:coordenador/course/course_archived_page.dart';
import 'package:coordenador/course/course_model.dart';
import 'package:coordenador/course/course_state.dart';
import 'package:flutter/material.dart';

class CourseArchivedConnector extends StatelessWidget {
  const CourseArchivedConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      // onInit: (store) => store.dispatch(ReadDocsCourseAction()),
      // onDispose: (store) => store.dispatch(ReadDocsCourseAction()),
      builder: (context, vm) => CourseArchivedPage(
        courseModelList: vm.courseModelList,
        unArchived: vm.unArchived,
      ),
    );
  }
}

class HomeViewModelFactory
    extends VmFactory<AppState, CourseArchivedConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        courseModelList: CourseState.selectCourseArchived(state),
        unArchived: (String id) {
          dispatch(SetCourseCurrentCourseAction(id: id));
          CourseModel courseModel = state.courseState.courseModelCurrent!;
          courseModel = courseModel.copyWith(isArchivedByCoord: false);
          dispatch(UpdateDocCourseAction(courseModel: courseModel));
        },
      );
}

class HomeViewModel extends Vm {
  final List<CourseModel> courseModelList;
  final Function(String) unArchived;
  HomeViewModel({
    required this.courseModelList,
    required this.unArchived,
  }) : super(equals: [
          courseModelList,
        ]);
}
