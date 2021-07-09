import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/resource/resource_model.dart';

class ReadDocsResourceAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> ReadDocsResourceAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection(ResourceModel.collection).get();
    List<ResourceModel> resourceModelList = [];
    resourceModelList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => ResourceModel.fromMap(
            queryDocumentSnapshot.id,
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    dispatch(SetResourceModelListResourceAction(
        resourceModelList: resourceModelList));
    return null;
  }
}

class SetResourceModelListResourceAction extends ReduxAction<AppState> {
  final List<ResourceModel> resourceModelList;

  SetResourceModelListResourceAction({required this.resourceModelList});
  @override
  AppState reduce() {
    return state.copyWith(
      resourceState: state.resourceState.copyWith(
        resourceModelList: resourceModelList,
      ),
    );
  }
}
