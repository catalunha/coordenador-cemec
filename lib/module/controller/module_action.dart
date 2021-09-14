import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/course/controller/course_action.dart';
import 'package:coordenador/module/controller/module_model.dart';
import 'package:coordenador/module/controller/module_state.dart';

class ReadDocsModuleAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> ReadDocsModuleAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(ModuleModel.collection)
        .where('courseId', isEqualTo: state.courseState.courseModelCurrent!.id)
        .where('isDeleted', isEqualTo: false)
        .get();
    List<ModuleModel> moduleModelList = [];
    moduleModelList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => ModuleModel.fromMap(
            queryDocumentSnapshot.id,
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    dispatch(SetModuleModelListModuleAction(moduleModelList: moduleModelList));
    return null;
  }
}

class ResetModuleStateModuleAction extends ReduxAction<AppState> {
  ResetModuleStateModuleAction();
  @override
  AppState reduce() {
    return state.copyWith(
      moduleState: ModuleState.initialState(),
    );
  }
}

class StreamDocsModuleAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    dispatch(ResetModuleStateModuleAction());
    print('--> StreamDocsModuleAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(ModuleModel.collection)
        .where('courseId', isEqualTo: state.courseState.courseModelCurrent!.id)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<ModuleModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                ModuleModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<ModuleModel> moduleModelList) {
      dispatch(
          SetModuleModelListModuleAction(moduleModelList: moduleModelList));
    });
    // BillState.billStream = streamList.listen((List<BillModel> billModelList) {
    //   dispatch(SetBillListBillAction(billModelList: billModelList));
    // });

    return null;
  }
}

class SetModuleModelListModuleAction extends ReduxAction<AppState> {
  final List<ModuleModel> moduleModelList;

  SetModuleModelListModuleAction({required this.moduleModelList});
  @override
  AppState reduce() {
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleModelList: moduleModelList,
      ),
    );
  }

  void after() {
    if (state.moduleState.moduleModelCurrent != null) {
      dispatch(SetModuleCurrentModuleAction(
          id: state.moduleState.moduleModelCurrent!.id));
    }
    // dispatch(ReadDocCourseOfModuleListModuleAction());
  }
}

class SetModuleCurrentModuleAction extends ReduxAction<AppState> {
  final String id;
  SetModuleCurrentModuleAction({
    required this.id,
  });
  @override
  AppState reduce() {
    print('--> SetModuleCurrentModuleAction $id');
    ModuleModel moduleModel = ModuleModel(
      '',
      courseId: '',
      title: '',
      description: '',
      syllabus: '',
      isArchivedByProf: false,
      isDeleted: false,
    );
    if (id.isNotEmpty) {
      moduleModel = state.moduleState.moduleModelList!
          .firstWhere((element) => element.id == id);
    }
    return state.copyWith(
      moduleState: state.moduleState.copyWith(
        moduleModelCurrent: moduleModel,
      ),
    );
  }
}

class CreateDocModuleAction extends ReduxAction<AppState> {
  final ModuleModel moduleModel;

  CreateDocModuleAction({required this.moduleModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(ModuleModel.collection);
    await docRef.add(moduleModel.toMap()).then((docRef) {
      print('--> Add ${docRef.id} em course.moduleOrder');
      dispatch(
          UpdateModuleOrderCourseAction(id: docRef.id, isUnionOrRemove: true));
    });
    return null;
  }
}

class UpdateDocModuleAction extends ReduxAction<AppState> {
  final ModuleModel moduleModel;

  UpdateDocModuleAction({required this.moduleModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(ModuleModel.collection)
        .doc(moduleModel.id);
    await docRef.update(moduleModel.toMap()).then((value) {
      if (moduleModel.isDeleted) {
        print('--> remove ${docRef.id} em course.moduleOrder');
        dispatch(UpdateModuleOrderCourseAction(
            id: docRef.id, isUnionOrRemove: false));
      }
    });
    return null;
  }
}
