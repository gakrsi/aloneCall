import 'dart:async';
import 'dart:convert';
import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/filter_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/local_storage_repository.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/view/home_view.dart';
import 'package:alonecall/app/modules/home/view/page/fliter_view.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeController extends GetxController {
  /// Current index in [HomeView]
  int currentTab = 0;
  int profileCurrentTab = 0;

  double lat = 0.0;
  double long = 0.0;

  int startAge = 0;
  int lastAge = 0;
  int initialDistance = 0;
  int lastDistance = 0;

  List<LatLng> latLong = <LatLng>[];

  bool isSwitched = false;
  String textValue = '';

  /// The current status of the page.
  PageStatus pageStatus = PageStatus.idle;

  ProfileModel model = ProfileModel();
  FilterModel filterModel = FilterModel();

  String city = '';
  String country = '';

  List<String> languageList = <String>[
    'English', 'Hindi', 'Bengali',
    'Marathi',
    'Telugu',
    'Tamil',
    'Gujarati', 'Urdu',
    'Kannada',
    'Odia (Oriya)',
    'Malayalam',
    'Punjabi',
    'Bodo',
    'Dogri',
    'Kashmiri',
    'Konkani',
    'Maithili',
    'Manipuri',
    'Nepali',
    'Sanskrit',
    'Santali Language',
    'Sindhi',
    'Assamese'
  ];

  final List<BottomNavigationBarItem> tab = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.location_pin), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.history), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ' '),
    const BottomNavigationBarItem(icon: Icon(Icons.money), label: ' '),
  ];



  @override
  void onInit() async {
    filterModel = await Repository().getFilterDetails();
    updateCurrentLocation();
    await Repository().latLongOfAllUser().then((value) {
      for (var i = 0; i < value.length; i++) {
        latLong.add(value[i].latLng);
      }
    });
    var data = await Repository().getProfile();
    var encoder = const JsonEncoder.withIndent('  ');
    var prettyPrint = encoder.convert(data);
    print(prettyPrint);
    await getCurrentLatLng();
    model = ProfileModel.fromJson(data);
    updateCoin();
    super.onInit();
  }

  void changeTab(int index) {
    currentTab = index;
    update();
  }

  String gender() {
    if (model.gender == 'Female') {
      return 'Male';
    }
    return 'Female';
  }

  Future<void> reloadProfileDetails() async {
    var data = await Repository().getProfile();
    model = ProfileModel.fromJson(data);
    var encoder = const JsonEncoder.withIndent('  ');
    var prettyPrint = encoder.convert(data);
    print(prettyPrint);
    update();
  }

  void updateCoin(){
    var coin = LocalRepository().getCoin();
    var audioCoin = LocalRepository().getCoin();

    if(coin > 0){
      Repository().updateCoin(model.coin - coin);
    }
    if(audioCoin > 0){
      Repository().updateAudioCoin(model.audioCoin - coin);
    }
  }

  void changeProfileTab(int index) {
    profileCurrentTab = index;
    update();
  }

  void updateCurrentLocation()  {
    Utility.getCurrentLocation().then((value) {
      city = value.city;
      country = value.country;
      update();
    });
  }

  /// Get current lat long of the device.
  Future<void> getCurrentLatLng() async {
    var latLong = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    lat = latLong.latitude;
    long = latLong.longitude;
    update();
    Repository().distanceStream(lat, long);
    Utility.printDLog('Current lat,long $lat, $long');
  }

  ///######################################[FilterView]################################

  void addLanguageToList(String value) {
    if(filterModel.language.contains(value)){
      filterModel.language.remove(value);
    }
    else{
      filterModel.language.add(value);
    }
    update();
  }

  void onApplyFilter(){
    Utility.printDLog('Apply filter');
    Utility.showLoadingDialog();
    Repository().updateFilter(filterModel).whenComplete(RoutesManagement.goToHome);

  }

  void updateAgeSlider(dynamic initAge, dynamic lastAge) {
    filterModel
      ..initAge = int.parse(initAge.toString().split('.')[0])
      ..lastAge = int.parse(lastAge.toString().split('.')[0]);
    update();
  }

  void updateDistanceSlider(dynamic initDistance, dynamic lastDistance) {
    filterModel
      ..initDistance = int.parse(initDistance.toString().split('.')[0])
      ..lastDistance = int.parse(lastDistance.toString().split('.')[0]);
    update();
  }

  ///######################################[PaymentView]################################

  Razorpay razorPay = Razorpay();
  Map<String, dynamic> options;
  bool isAudio;
  int amount;
  int minute;

  void _initializePayment() {
    razorPay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    !isAudio
        ? Repository().addVideoCoin(minute*60 + model.coin)
        : Repository().addAudioCoin(minute*60 + model.audioCoin);
    isAudio
        ? model.audioCoin =  minute*60 + model.audioCoin
        : model.coin = minute*60 + model.coin;
    update();
    razorPay.clear();
    Utility.showError('SUCCESS: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utility.showError('ERROR: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utility.showError('EXTERNAL_WALLET: ${response.walletName}');
  }

  void checkout() {
    options = <String, dynamic>{
      'key': 'rzp_test_HGESD2Chi4Y3yy',
      'amount': amount * 100,
      'name': 'AloneCall.com',
      'description': 'Coins',
      'prefill': {'email': 'alonecall@gmail.com', 'contact': '8888888888'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      Utility.printDLog('$e');
    }
  }

  void onClickPlanOption(bool audio, int am, int min){
    _initializePayment();
    isAudio = audio;
    amount = am;
    minute = min;
    update();
    checkout();
  }

  /// Update the page status
  /// [pageStatus] : the new page status.
  void updatePageStatus(PageStatus pageStatus) {
    this.pageStatus = pageStatus;
    update();
  }
}
