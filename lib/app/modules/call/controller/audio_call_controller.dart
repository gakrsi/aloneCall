import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/network_constant.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCallController extends GetxController{
  CallingModel callingModel = Get.arguments[0] as CallingModel;
  ProfileModel userModel = Get.arguments[1] as ProfileModel;
  RtcEngine _engine;
  String channelId = 'channelId';
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = true,
      playEffect = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 0, _playbackVolume = 0, _inEarMonitoringVolume = 0;
  StreamSubscription callStreamSubscription;


  @override
  void onInit() {
    _initEngine();
    super.onInit();
  }


  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
    callStreamSubscription.cancel();
  }

  Future<void>_initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(NetworkConstants.agoraRtcKey));
    addPostFrameCallback();
    await _addListeners();
    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _joinChannel();
  }


  void addPostFrameCallback() {
    Utility.printDLog('call stream called in video screen');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription =  Repository().videoCallStream().listen((DocumentSnapshot ds) {
        if(ds.data() == null){
          leaveChannel();
        }
      });
    });
  }


  Future<void> _addListeners() async {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess $channel $uid $elapsed');
          isJoined = true;
          update();
      },
      leaveChannel: (stats) async {
        log('leaveChannel ${stats.toJson()}');
          isJoined = false;
          update();
      },
    ));
  }

  Future<void>_joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    await _engine
        .joinChannel(null, callingModel.callerUid, null, 0)
        .catchError((Error onError) {
      print('error ${onError.toString()}');
    });
  }


  Future<void> leaveChannel() async {
    await Repository().endVideoCall(callingModel).then((value) async {
      await _engine.leaveChannel();
    });
  }

  void _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
        openMicrophone = !openMicrophone;
        update();
    }).catchError((Error err) {
      log('enableLocalAudio $err');
    });
  }

  void _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
        enableSpeakerphone = !enableSpeakerphone;
        update();
    }).catchError((Error err) {
      log('setEnableSpeakerphone $err');
    });
  }

  void _onChangeInEarMonitoringVolume(double value) {
      _inEarMonitoringVolume = value;
      update();
    _engine.setInEarMonitoringVolume(value.toInt());
  }

  void _toggleInEarMonitoring(bool value) {
      _enableInEarMonitoring = value;
      update();
    _engine.enableInEarMonitoring(value);
  }

}