import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/course_model.dart';

class SetCourseCurrentCourseAction extends ReduxAction<AppState> {
  final String id;
  SetCourseCurrentCourseAction({
    required this.id,
  });
  @override
  AppState reduce() {
    print('--> SetCourseCurrentCourseAction $id');
    CourseModel courseModel = CourseModel(
      '',
      coordinatorUserId: '',
      title: '',
      description: '',
      syllabus: '',
      isArchivedByAdm: false,
      isArchivedByCoord: false,
      isDeleted: false,
    );
    if (id.isNotEmpty) {
      courseModel = state.courseState.courseModelList!
          .firstWhere((element) => element.id == id);
    }
    return state.copyWith(
      courseState: state.courseState.copyWith(
        courseModelCurrent: courseModel,
      ),
    );
  }
}

class CreateDocCourseAction extends ReduxAction<AppState> {
  final CourseModel courseModel;

  CreateDocCourseAction({required this.courseModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(CourseModel.collection).doc();
    await docRef.set(courseModel.toMap());
    return null;
  }
}

class UpdateDocCourseAction extends ReduxAction<AppState> {
  final CourseModel courseModel;

  UpdateDocCourseAction({required this.courseModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(CourseModel.collection)
        .doc(courseModel.id);
    await docRef.update(courseModel.toMap());
    return null;
  }
}

class ReadDocsCourseAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(CourseModel.collection)
        .where('isDeleted', isEqualTo: false)
        .get();
    List<CourseModel> courseModelList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => CourseModel.fromMap(
            queryDocumentSnapshot.id,
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    dispatch(SetCourseModelListCourseAction(courseModelList: courseModelList));
    return null;
  }
}

class SetCourseModelListCourseAction extends ReduxAction<AppState> {
  final List<CourseModel> courseModelList;

  SetCourseModelListCourseAction({required this.courseModelList});
  @override
  AppState reduce() {
    return state.copyWith(
      courseState: state.courseState.copyWith(
        courseModelList: courseModelList,
      ),
    );
  }
}
