import 'package:async_redux/async_redux.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coordenador/app_state.dart';
import 'package:coordenador/login/login_action.dart';
import 'package:coordenador/user/user_model.dart';
import 'package:coordenador/user/user_state.dart';

class ChangeStatusFirestoreUserUserAction extends ReduxAction<AppState> {
  final StatusFirestoreUser statusFirestoreUser;

  ChangeStatusFirestoreUserUserAction({required this.statusFirestoreUser});
  @override
  AppState reduce() {
    return state.copyWith(
        userState: state.userState.copyWith(
      statusFirestoreUser: statusFirestoreUser,
    ));
  }
}

class GetDocGoogleAccountUserAction extends ReduxAction<AppState> {
  final String uid;

  GetDocGoogleAccountUserAction({required this.uid});
  @override
  Future<AppState> reduce() async {
    dispatch(ChangeStatusFirestoreUserUserAction(
        statusFirestoreUser: StatusFirestoreUser.checkingInFirestore));
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var querySnapshot = await firebaseFirestore
        .collection(UserModel.collection)
        .where('uid', isEqualTo: uid)
        .where('isActive', isEqualTo: true)
        .get();
    var documentIdList = querySnapshot.docs
        .map((queryDocumentSnapshot) => queryDocumentSnapshot.id)
        .toList();
    print('--> GetDocUserAsyncUserAction: $documentIdList');
    if (documentIdList.length == 1) {
      String documentId = documentIdList[0];
      await dispatch(UpdateDocWithGoogleAccountUserAction(id: documentId));
      await dispatch(ReadDocUserUserAction(id: documentId));
      return state.copyWith(
        userState: state.userState.copyWith(
          statusFirestoreUser: StatusFirestoreUser.inFirestore,
        ),
      );
    } else {
      print('--> GetDocUserAsyncUserAction: users NAO encontrado');
      dispatch(SignOutLoginAction());
      return state.copyWith(
        userState: state.userState.copyWith(
          statusFirestoreUser: StatusFirestoreUser.outFirestore,
        ),
      );
    }
  }
}

class ReadDocUserUserAction extends ReduxAction<AppState> {
  final String id;

  ReadDocUserUserAction({required this.id});
  @override
  Future<AppState> reduce() async {
    dispatch(ChangeStatusFirestoreUserUserAction(
        statusFirestoreUser: StatusFirestoreUser.checkingInFirestore));
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var docRef = firebaseFirestore.collection(UserModel.collection).doc(id);

    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();
    UserModel userModel =
        UserModel.fromMap(documentSnapshot.id, documentSnapshot.data()!);
    return state.copyWith(
      userState: state.userState.copyWith(
        userCurrent: userModel,
      ),
    );
  }
}

class UpdateDocWithGoogleAccountUserAction extends ReduxAction<AppState> {
  final String id;
  UpdateDocWithGoogleAccountUserAction({required this.id});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DocumentReference docRef =
        firebaseFirestore.collection(UserModel.collection).doc(id);
    Map<String, dynamic> googleUser = {};
    googleUser['displayName'] = state.loginState.userFirebaseAuth!.displayName;
    googleUser['photoURL'] = state.loginState.userFirebaseAuth!.photoURL;
    googleUser['phoneNumber'] = state.loginState.userFirebaseAuth!.phoneNumber;
    googleUser['email'] = state.loginState.userFirebaseAuth!.email;
    await docRef.update(googleUser);
    return null;
  }
}
