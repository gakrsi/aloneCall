import 'dart:async';

import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class CallService extends GetxController {
  StreamSubscription callStreamSubscription;
  bool callReceived = false;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

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

  void playIncomingRingTune(){
    assetsAudioPlayer.open(
      Audio('assets/audio/ringing_tume.mp3'),
      autoStart: true,
    );
  }

  void updateCallStatusReceived(){
    callReceived = true;
    update();
  }

  void updateCallStatusDisConnected(){
    callReceived = false;
    update();
  }

  void _addPostFrameCallback(){
    updateCallStatusDisConnected();
    Utility.printDLog('Stream Listen to Incoming Call');
    SchedulerBinding.instance.addPostFrameCallback((_){
      callStreamSubscription =
          Repository().videoCallStream().listen((DocumentSnapshot ds) async{
        if (ds.exists) {
          var callingModel = CallingModel.fromJson(ds.data() as Map<String, dynamic>);
          if ((callingModel.callerUid != Repository().uid) && !callReceived) {
            playIncomingRingTune();
            Utility.showCallPickupDialog(callingModel);
            Utility.printDLog('${ds.data()}');
          }
        }
        else {
          await assetsAudioPlayer.pause();
          updateCallStatusDisConnected();
          Utility.closeDialog();
        }
      });
    });
  }
}

