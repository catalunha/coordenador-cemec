import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:coordenador/app_state.dart';
import 'package:coordenador/upload/upload_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:async_redux/async_redux.dart';
import 'package:file_picker/file_picker.dart';

class RestartingStateUploadAction extends ReduxAction<AppState> {
  RestartingStateUploadAction();
  AppState reduce() {
    return state.copyWith(uploadState: UploadState.initialState());
  }
}

class SetUrlForDownloadUploadAction extends ReduxAction<AppState> {
  final String url;
  SetUrlForDownloadUploadAction({required this.url});
  AppState reduce() {
    return state.copyWith(
        uploadState: state.uploadState.copyWith(urlForDownload: url));
  }
}

class SelectFileUploadAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    dispatch(RestartingStateUploadAction());
    UploadForFirebase uploadFirebase = UploadForFirebase();
    bool status = await uploadFirebase.selectFile();
    if (status) {
      return state.copyWith(
        uploadState: state.uploadState.copyWith(
          selectedLocalFile: uploadFirebase.file,
        ),
      );
    } else {
      return state.copyWith(uploadState: UploadState.initialState());
    }
  }
}

class SelectFileUploadAction2 extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    dispatch(RestartingStateUploadAction());
    UploadForFirebase2 uploadFirebase2 = UploadForFirebase2();
    bool status = await uploadFirebase2.selectFile2();
    if (status) {
      return state.copyWith(
        uploadState: state.uploadState.copyWith(
          fileName: uploadFirebase2.fileName,
          fileBytes: uploadFirebase2.fileBytes,
        ),
      );
    } else {
      return state.copyWith(uploadState: UploadState.initialState());
    }
  }
}

class UploadingFileUploadAction extends ReduxAction<AppState> {
  final String pathInFirestore;

  UploadingFileUploadAction({required this.pathInFirestore});
  Future<AppState> reduce() async {
    UploadForFirebase uploadForFirebase = UploadForFirebase();
    File? file = state.uploadState.selectedLocalFile;
    if (file != null) {
      UploadTask? task = uploadForFirebase.uploadingFile(file, pathInFirestore);
      return state.copyWith(
          uploadState: state.uploadState.copyWith(uploadTask: task));
    } else {
      return state.copyWith(uploadState: UploadState.initialState());
    }
  }

  void after() => dispatch(StreamUploadTask());
}

class UploadingFileUploadAction2 extends ReduxAction<AppState> {
  final String pathInFirestore;

  UploadingFileUploadAction2({required this.pathInFirestore});
  Future<AppState> reduce() async {
    UploadForFirebase2 uploadForFirebase2 = UploadForFirebase2();
    String? file = state.uploadState.fileName;
    if (file != null) {
      UploadTask? task = uploadForFirebase2.uploadingBytes2(pathInFirestore,
          state.uploadState.fileName!, state.uploadState.fileBytes!);

      return state.copyWith(
          uploadState: state.uploadState.copyWith(uploadTask: task));
    } else {
      return state.copyWith(uploadState: UploadState.initialState());
    }
  }

  void after() => dispatch(StreamUploadTask());
}

class UpdateUploadPorcentageUploadAction extends ReduxAction<AppState> {
  final double value;

  UpdateUploadPorcentageUploadAction({required this.value});
  AppState reduce() {
    return state.copyWith(
      uploadState: state.uploadState.copyWith(
        uploadPercentage: value,
      ),
    );
  }
}

class UpdateUrlForDownloadUploadAction extends ReduxAction<AppState> {
  UpdateUrlForDownloadUploadAction();
  Future<AppState?> reduce() async {
    if (state.uploadState.uploadTask != null) {
      UploadTask task = state.uploadState.uploadTask!;
      final snapshot = await task.whenComplete(() {});
      String url = await snapshot.ref.getDownloadURL();
      return state.copyWith(
        uploadState: state.uploadState.copyWith(
          urlForDownload: url,
        ),
      );
    } else {
      return null;
    }
  }
}

class StreamUploadTask extends ReduxAction<AppState> {
  Future<AppState?> reduce() async {
    print('StreamUploadTask');
    if (state.uploadState.uploadTask != null) {
      UploadTask uploadTask = state.uploadState.uploadTask!;
      Stream<TaskSnapshot> streamTaskSnapshot = uploadTask.snapshotEvents;
      streamTaskSnapshot.listen((TaskSnapshot event) {
        final progress = event.bytesTransferred / event.totalBytes;
        final percentage = (progress * 100);
        print(percentage);
        dispatch(UpdateUploadPorcentageUploadAction(value: percentage));
      });
      // dispatch(UpdateUrlForDownloadUploadAction());

      return null;
    } else {
      return null;
    }
  }

  void after() => dispatch(UpdateUrlForDownloadUploadAction());
}

class UploadForFirebase {
  File? file;
  Future<bool> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (result == null) return false;
    final path = result.files.single.path!;

    file = File(path);
    return true;
  }

  UploadTask? uploadingFile(File file, String pathInFirestore) {
    final fileName = basename(file.path);
    final destination = '$pathInFirestore/$fileName';
    var task = _uploadFile(destination, file);
    if (task == null) return null;
    return task;
  }
  // Future<bool> uploadFile(String pathInFirestore) async {
  //   if (file == null) return false;
  //   final fileName = basename(file!.path);
  //   final destination = '$pathInFirestore/$fileName';
  //   task = _uploadFile(destination, file!);
  //   if (task == null) return false;
  //   final snapshot = await task!.whenComplete(() {});
  //   urlDownload = await snapshot.ref.getDownloadURL();
  //   return true;
  //   print('Download-link:$urlDownload');
  // }

  static UploadTask? _uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? _uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

class UploadForFirebase2 {
  File? file;
  String? fileName;
  Uint8List? fileBytes;
  late final FilePickerResult? pickFile;
  Future<bool> selectFile2() async {
    this.pickFile = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (pickFile?.files.first == null) return false;
    _choiceEnviroment();

    print('$fileName');
    print('$fileBytes');
    return true;
  }

  void _choiceEnviroment() {
    if (kIsWeb) {
      //It's web
      _fileInWeb();
    } else if (Platform.isAndroid) {
      //it's Android
      _fileInAndroid();
    }
  }

  void _fileInWeb() {
    this.fileBytes = pickFile!.files.first.bytes;
    this.fileName = pickFile!.files.first.name;
    print('$fileName');
    print('$fileBytes');
  }

  void _fileInAndroid() async {
    final path = pickFile!.files.single.path!;

    file = File(path);
    this.fileName = basename(file!.path);
    this.fileBytes = file!.readAsBytesSync();
    print('$fileName');
    print('$fileBytes');
  }

  UploadTask? uploadingFile2(File file, String pathInFirestore) {
    final fileName = basename(file.path);
    final destination = '$pathInFirestore/$fileName';
    var task = _uploadFile2(destination, file);
    if (task == null) return null;
    return task;
  }
  // Future<bool> uploadFile(String pathInFirestore) async {
  //   if (file == null) return false;
  //   final fileName = basename(file!.path);
  //   final destination = '$pathInFirestore/$fileName';
  //   task = _uploadFile(destination, file!);
  //   if (task == null) return false;
  //   final snapshot = await task!.whenComplete(() {});
  //   urlDownload = await snapshot.ref.getDownloadURL();
  //   return true;
  //   print('Download-link:$urlDownload');
  // }

  static UploadTask? _uploadFile2(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  UploadTask? uploadingBytes2(
      String pathInFirestore, String fileName, Uint8List fileBytes) {
    UploadTask? task;
    try {
      final ref = FirebaseStorage.instance.ref('$pathInFirestore/$fileName');
      task = ref.putData(fileBytes);
    } on FirebaseException catch (e) {
      print('--> uploadingBytes2 error $e');
      return null;
    }
    return task;
  }

  static UploadTask? _uploadBytes2(
      String destination, String fileName, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref('$destination/$fileName');
      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
