import 'dart:io';

import 'package:alonecall/app/data/model/bank_detail_model.dart';
import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/distance_model.dart';
import 'package:alonecall/app/data/model/filter_model.dart';
import 'package:alonecall/app/data/model/history_model.dart';
import 'package:alonecall/app/data/model/location_avtar_model.dart';
import 'package:alonecall/app/data/model/plan_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/model/withdraw_model.dart';
import 'package:alonecall/app/data/repository/friebase_key_constant.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Repository {
  Repository() {
    uid = currentUser();
  }
  String uid;
  Stream<QuerySnapshot> userStream(String gender) => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .where('gender', isNotEqualTo: gender)
      .snapshots();

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

  Stream<QuerySnapshot> onlineUser(String sex) => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .where(
        'online',
        isEqualTo: true,
      ).where('gender',isEqualTo: sex == 'Male'?'Female':'Male')
      .snapshots();

  Stream<QuerySnapshot> searchUser(String item,) => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .where('name', isGreaterThanOrEqualTo: item)
      // .where('gender',isEqualTo: 'Female')
      .snapshots();

  Stream<QuerySnapshot> nearYou(String item) => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .where('city', isGreaterThanOrEqualTo: item)
      .snapshots();

  Stream<QuerySnapshot> blockUserStream() => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .doc(uid)
      .collection(FirebaseConstant.blockUser)
      .snapshots();

  Stream<QuerySnapshot> historyStream() => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .doc(uid)
      .collection(FirebaseConstant.history)
      .orderBy('date', descending: true)
      .snapshots();
  Stream<QuerySnapshot> notificationStream() => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .doc(uid)
      .collection(FirebaseConstant.history)
      .orderBy('date', descending: true)
      .snapshots();
  Stream<QuerySnapshot> withdrawStream() => FirebaseFirestore.instance
      .collection(FirebaseConstant.user)
      .doc(uid)
      .collection(FirebaseConstant.withdraw)
      .orderBy('date', descending: true)
      .snapshots();

  void distanceStream(double lat, double long) async {
    var user = await firebaseFireStore.collection(FirebaseConstant.user).get();
    for (var i = 0; i < user.docs.length; i++) {
      var distanceModel = DistanceModel()
        ..uid = user.docs[i]['uid'] as String
        ..image = user.docs[i]['profile_image_url'][0] as String
        ..distance = Geolocator.distanceBetween(lat, long,
                user.docs[i]['lat'] as double, user.docs[i]['long'] as double)
            .ceilToDouble();
      print(distanceModel.distance / 1000.ceilToDouble());
    }
  }

  Future<bool> checkUserOnCall(String receiverUid) async {
    var busy = false;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(receiverUid)
        .collection(FirebaseConstant.call)
        .get()
        .then((value) {
      value.docs.isNotEmpty ? busy = true : busy = false;
    });
    return busy;
  }

  Future<ProfileModel> getUserDataByUid(String uid) async {
    ProfileModel profileModel;
    var data  = await firebaseFireStore.collection(FirebaseConstant.user).doc(uid).get();
    profileModel = ProfileModel.fromJson(data.data());
    return profileModel;
  }

  Future<int> checkAudioBalance() async {
    Map<String, dynamic> data;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .get()
        .then((value) {
      data = value.data();
    });
    return data['audio_coin'] as int;
  }

  Future<int> checkVideoBalance() async {
    Map<String, dynamic> data;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .get()
        .then((value) {
      data = value.data();
    });
    return data['coin'] as int;
  }

  Future<bool> checkUserIsOnline(String receiverUid) async {
    Map<String, dynamic> userData;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(receiverUid)
        .get()
        .then((value) {
      userData = value.data();
    });
    return userData['online'] as bool;
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
    Utility.printDLog('End call function called');
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(obj.callerUid)
        .collection(FirebaseConstant.call)
        .doc(obj.callerUid)
        .delete();
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(obj.receiverUid)
        .collection(FirebaseConstant.call)
        .doc(obj.receiverUid)
        .delete();
  }

  void makeCallConnected(CallingModel obj) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.call)
        .doc(uid)
        .update({'is_connected': true});
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(obj.receiverUid)
        .collection(FirebaseConstant.call)
        .doc(obj.receiverUid)
        .update({'is_connected': true});
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
    var languageList  = <String>[];
    languageList.add(obj.lang);
    var filterModel = FilterModel()
      ..initAge = 18
      ..lastAge = 100
      ..initDistance = 0
      ..lastDistance = 100
      ..language = <String>[
        'English',
        'Hindi',
        'Marathi',
        'Telugu',
        'Tamil',
      ];

    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .set(obj.toMap(obj));
    await addFilter(filterModel);
  }

  Future<void> requestMoney(ProfileModel obj) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .set(obj.toMap(obj));
  }

  Future<void> updateFilter(FilterModel filterModel) async{
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.userDetails)
        .doc(FirebaseConstant.filter).update(filterModel.toJson(filterModel));
  }

  Future<void> addBankDetails(AddBankModel addBankModel) async{
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.userDetails)
        .doc(FirebaseConstant.bankDetail).set(addBankModel.toMap(addBankModel));
  }


  Future<AddBankModel> getBankDetails() async{
    DocumentSnapshot data =  await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.userDetails)
        .doc(FirebaseConstant.bankDetail).get();
    return AddBankModel.fromJson(data.data() as Map<String,dynamic>);
  }

  Future<bool> checkBank() async{
    bool val;
    var data =  await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.userDetails)
        .doc(FirebaseConstant.bankDetail).get().then((value) => value.exists ? val = true : val = false);;
    return val;
  }

  Future<void> updateProfile(ProfileModel obj) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .update(obj.toMap(obj));
  }

  Future<void> addHistory(HistoryModel model) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(model.callerUid)
        .collection(FirebaseConstant.history)
        .add(model.toJson(model));
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(model.receiverUid)
        .collection(FirebaseConstant.history)
        .add(model.toJson(model));
  }

  Future<void> withdraw(Withdraw model) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.withdraw)
        .add(model.toJson(model));
    await firebaseFireStore
        .collection(FirebaseConstant.request)
        .add(model.toJson(model));
  }

  Future<FilterModel> getFilterDetails() async {
    var data = <String,dynamic>{};
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.userDetails)
        .doc(FirebaseConstant.filter)
        .get().then((value){
          data = value.data();
          Utility.printDLog('$data');
    });
    return FilterModel.fromJson(data);
  }

  Future<void> addFilter(FilterModel filterModel) async{
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.userDetails)
        .doc(FirebaseConstant.filter).set(filterModel.toJson(filterModel));
  }

  Future<Map<String, dynamic>> getProfile() async {
    Utility.printDLog('Get profile function called');
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

  Future<String> uploadProfileImage(File file, int index) async {
    print('uploadProfileImage');
    String url;
    var reference = firebaseStorage.ref('$uid/$index.png');
    var uploadTask = await reference.putFile(file).whenComplete(() async {
      url = await reference.getDownloadURL();
    });
    return url;
  }

  Future<void> makeUserOnline() async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .update({'online': true});
  }

  Future<void> makeUserOffline() async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .update({'online': false});
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

  Future<void> blockUser(ProfileModel model) async {
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.blockUser)
        .doc(model.uid)
        .set(model.toMap(model));
  }

  void unBlockUser(ProfileModel model) {
    firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.blockUser)
        .doc(model.uid)
        .delete();
  }

  Future<bool> checkUserIsBlocked(ProfileModel model) async {
    var val = false;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .collection(FirebaseConstant.blockUser)
        .doc(model.uid)
        .get()
        .then((value) => value.exists ? val = true : val = false);
    return val;
  }

  Future<bool> checkUserIsBlockedWhileCalling(ProfileModel model) async {
    var val = false;
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(model.uid)
        .collection(FirebaseConstant.blockUser)
        .doc(uid)
        .get()
        .then((value) => value.exists ? val = true : val = false);
    Utility.printDLog('Blocked By user $val');
    return val;
  }

  Future<void> updateAudioCoin(int coin) async {
      await firebaseFireStore
          .collection(FirebaseConstant.user)
          .doc(uid)
          .update({'audio_coin': coin});
  }

  Future<void> updateCoin(int coin) async{
    await firebaseFireStore
        .collection(FirebaseConstant.user)
        .doc(uid)
        .update({'coin': coin});
  }

  Future<void> addCoinToUser(String uid, int amount) async{
    await firebaseFireStore.collection(FirebaseConstant.user).doc(uid).get().then((value) async{
      var  presentCoin = value.data()['coin'] as int;
      var am = amount + presentCoin;
      await firebaseFireStore.collection(FirebaseConstant.user).doc(uid).update({'coin':am});
    });
  }

  Future<void> addAudioCoinToUser(String uid, int amount) async{
    await firebaseFireStore.collection(FirebaseConstant.user).doc(uid).get().then((value) async{
      var  presentCoin = value.data()['audio_coin'] as int;
      var am = amount + presentCoin;
      await firebaseFireStore.collection(FirebaseConstant.user).doc(uid).update({'audio_coin':am});
    });
  }

  Future<List<AvatarModel>> latLongOfAllUser() async {
    Utility.printDLog('LatLong of all user function called');
    var latLong = <AvatarModel>[];
    var user = await firebaseFireStore.collection(FirebaseConstant.user).get();
    for (var i = 0; i < user.docs.length; i++) {
      var avatar = AvatarModel(
          LatLng(user.docs[i]['lat'] as double, user.docs[i]['long'] as double),
          user.docs[i]['uid'] as String,
          user.docs[i]['profile_image_url'][0] as String);
      latLong.add(avatar);
    }
    return latLong;
  }

  String currentUser() => firebaseAuth.currentUser == null ? '' : firebaseAuth.currentUser.uid;

  bool isUserLogin() {
    if (firebaseAuth.currentUser == null) {
      return false;
    }
    return true;
  }

  Future<List<PlanModel>> getPlanDetails() async {
    var planList = <PlanModel>[];
    await firebaseFireStore.collection(FirebaseConstant.plan).get().then((value){
      value.docs.forEach((element) {
        print(element.data());
        planList.add(PlanModel.fromJson(element.data()));
      });
    });
    return planList;
  }

  void logout() {
    firebaseAuth.signOut();
    RoutesManagement.goToLoginScreen();
  }
}
