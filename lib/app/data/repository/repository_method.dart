import 'dart:io';

import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/friebase_key_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Repository {
  Repository() {
    uid = currentUser();
  }
  String uid;

  Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection(FirebaseConstant.user).snapshots();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  Future<void> startVideoCall(
      CallingModel reciModel, CallingModel dialModel) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.call)
        .doc(uid)
        .set(dialModel.toMap(dialModel));
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(reciModel.callerUid)
        .collection(FirebaseConstant.call)
        .doc(reciModel.callerUid)
        .set(reciModel.toMap(reciModel));
  }

  Future<void> endVideoCall(CallingModel obj) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.call)
        .doc(uid)
        .delete();
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(obj.callerUid)
        .collection(FirebaseConstant.call)
        .doc(obj.callerUid)
        .delete();
  }

  Future<bool> checkProfileCreate() async {
    var ok = false;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .get()
        .then((value) {
      value.exists ? ok = true : ok = false;
    });
    return ok;
  }

  Future<void> createProfile(ProfileModel obj) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .set(obj.toMap(obj));
  }

  Future<Map<String, dynamic>> getProfile() async {
    Map<String, dynamic> userData;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .get()
        .then((value) {
      userData = value.data();
    });
    return userData;
  }

  Future<String> uploadProfileImage(File file) async {
    var url = '';
    var reference = firebaseStorage.ref('images/defaultProfile.png');
    var uploadTask = reference.putFile(file).whenComplete(() {
      url = reference.getDownloadURL() as String;
    });
    return url;
  }

  String currentUser() => firebaseAuth.currentUser.uid;

  void logout() => firebaseAuth.signOut();
}
