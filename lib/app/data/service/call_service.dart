import 'dart:async';

import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CallService extends GetxController{
  StreamSubscription callStreamSubscription;
  @override
  void onInit() {
    _addPostFrameCallback();
    super.onInit();
  }

  @override
  void onClose() {
    callStreamSubscription.cancel();
    super.onClose();
  }

  void _addPostFrameCallback() {
    Utility.printDLog('Stream Listen to Incoming Call');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription =  Repository().videoCallStream().listen((DocumentSnapshot ds) {
        Utility.printDLog('${ds.data()}');
      });
    });
  }
}
