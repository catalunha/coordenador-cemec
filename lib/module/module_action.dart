import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/module/module_model.dart';

class ReadDocsModuleAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> ReadDocsModuleAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(ModuleModel.collection)
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
    DocumentReference docRef =
        firebaseFirestore.collection(ModuleModel.collection).doc();
    await docRef.set(moduleModel.toMap());
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
    await docRef.update(moduleModel.toMap());
    return null;
  }
}
