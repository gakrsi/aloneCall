import 'dart:io';

import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/friebase_key_constant.dart';
import 'package:alonecall/app/routes/routes_management.dart';
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

  Stream<DocumentSnapshot> videoCallStream() {
    var callStream = FirebaseFirestore.instance
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.call)
        .doc(uid)
        .snapshots();
    return callStream;
  }

  Stream<QuerySnapshot> onlineUser() => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .where('online', isEqualTo: true)
      .snapshots();

  Future<bool> checkUserOnCall(String reciUid)async {
    var busy = false;
    await firebaseFireStore.collection(FirebaseConstant.user).doc(reciUid).collection(FirebaseConstant.call).get().then((value){
      value.docs.isNotEmpty ? busy = true : busy = false;
    });
    return busy;
  }

  Future<void> startVideoCall(CallingModel dialModel) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.call)
        .doc(uid)
        .set(dialModel.toMap(dialModel));
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(dialModel.receiverUid)
        .collection(FirebaseConstant.call)
        .doc(dialModel.receiverUid)
        .set(dialModel.toMap(dialModel));
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
        .doc(obj.receiverUid)
        .collection(FirebaseConstant.call)
        .doc(obj.receiverUid)
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

  Future<String> uploadProfileImage(File file,int index) async {
    print('uploadProfileImage');
    String url;
    var reference = firebaseStorage.ref('$uid/$index.png');
    var uploadTask = await reference.putFile(file).whenComplete(() async {
      url =  await reference.getDownloadURL() ;
    });
    return url;
  }

  Future<void> makeUserOnline() async {
      await firebaseFireStore
          .collection(FirebaseConstant.user)
          .doc(uid)
          .update({'online': true});
  }

  Future<void> addAudioCoin(int amount) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .update({'audio_coin': amount});
  }

  Future<void> addVideoCoin(int amount) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .update({'coin': amount});
  }

  Future<void> makeUserOffline() async {
      await firebaseFireStore
          .collection(FirebaseConstant.user)
          .doc(uid)
          .update({'online': false});
  }


  String currentUser() =>
      firebaseAuth.currentUser == null ? '' : firebaseAuth.currentUser.uid;

  bool isUserLogin(){
    if(firebaseAuth.currentUser == null){
      return false;
    }
    return true;
  }

  void logout(){
    firebaseAuth.signOut();
    RoutesManagement.goToLoginScreen();
  }
}
