import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/network_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallController extends GetxController {
  RtcEngine _engine;
  CallingModel callingModel;
  bool isJoined = false, switchCamera = true, switchRender = true, muted = false;
  List<int> remoteUid = [];
  StreamSubscription callStreamSubscription;


  @override
  void onInit() {
    callingModel = Get.arguments as CallingModel;
    _initEngine();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(NetworkConstants.agoraRtcKey));
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _joinChannel();
  }

  void addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription = Repository()
          .videoCallStream()
          .listen((DocumentSnapshot ds) {
            if(ds.data == null){
              Get.back<void>();
            }
      });
    });
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess $channel $uid $elapsed');
          isJoined = true;
          update();
      },
      userJoined: (uid, elapsed) {
        log('userJoined  $uid $elapsed');
          remoteUid.add(uid);
          update();
      },
      userOffline: (uid, reason) {
        log('userOffline  $uid $reason');
          remoteUid.removeWhere((element) => element == uid);
          update();
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
          isJoined = false;
          remoteUid.clear();
          update();
      },
    ));
  }

  Future<void>_joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(null, callingModel.callerUid, null, 0);
  }

  Future<void> leaveChannel() async {
    await _engine.leaveChannel();
  }

  void switchCam() {
    _engine.switchCamera().then((value) {
        switchCamera = !switchCamera;
        update();
    }).catchError((Error err) {
      log('switchCamera $err');
    });
  }

  void switchRen() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
      update();
  }

  void _onToggleMute(){

    _engine.muteLocalAudioStream(muted).then((value) {
      muted = !muted;
      update();
    });
  }

  /// Helper function to get list of native views
  // List<Widget> _getRenderViews() {
  //   final List<AgoraRenderWidget> list = [
  //     RtcRenderWidget(0, local: true, preview: true),
  //   ];
  //   _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
  //   return list;
  // }

  /// Toolbar layout
  Widget toolbar() => Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              muted ? Icons.mic : Icons.mic_off,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
          ),
          RawMaterialButton(
            onPressed: () => Repository().endVideoCall(callingModel),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
          ),
          RawMaterialButton(
            onPressed: switchCam,
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: const Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
          )
        ],
      ),
    );
}
