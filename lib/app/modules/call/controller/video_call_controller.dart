import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/model/calling_model.dart';
import 'package:alonecall/app/data/model/history_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/utils/network_constant.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallController extends GetxController {
  Repository repo = Repository();
  int callDuration = 0;
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  final HomeController _controller = Get.find();
  bool isNotDial;
  String callStatusText = 'Connecting...';
  RtcEngine _engine;
  CallingModel callingModel = Get.arguments as CallingModel;
  bool isJoined = false, switchCamera = true, switchRender = true, muted = false;
  List<int> remoteUid = [];
  StreamSubscription callStreamSubscription;

  bool isReceiverBig = false;

  void addHistory(){
    var model = HistoryModel()
      ..callerName = callingModel.callerName
      ..callerUid = callingModel.callerUid
      ..callerImage = callingModel.callerImage
      ..receiverUid = callingModel.receiverUid
      ..receiverName = callingModel.receiverName
      ..receiverImage = callingModel.receiverImage
      ..isAudio = false
      ..date = Timestamp.now()
      ..time = Timestamp.now()
      ..callDuration = callDuration
    ;
    Repository().addHistory(model);
  }

  void changeSize(){
    isReceiverBig =!isReceiverBig;
    update();}

  void checkIsDial(){
    isNotDial = callingModel.receiverUid == repo.uid;
    update();
  }

  Future<void> checkUserAvailabilityAndBalance() async {
    var onlineCheck = await repo.checkUserIsOnline(callingModel.receiverUid);
    // var busyCheck = await repo.checkUserOnCall(callingModel.receiverUid);
    if(!onlineCheck){
      updateCallStatus(CallStatus.offline);
    }
    else{
      updateCallStatus(CallStatus.ringing);
      await repo.startVideoCall(callingModel);
    }
  }

  @override
  void onInit() {
    startTimer();
    _initEngine();
    checkUserAvailabilityAndBalance();
    checkIsDial();
    super.onInit();
  }

  @override
  void onClose() {
    callStreamSubscription.cancel();
    _engine.destroy();
    super.onClose();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(NetworkConstants.agoraRtcKey));
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _joinChannel();
    _addListeners();
    addPostFrameCallback();
  }

  void addPostFrameCallback() {
    print('###########################################################################');
    Utility.printDLog('call stream called in video screen');
    print('call stream called in video screen');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription =  Repository().videoCallStream().listen((DocumentSnapshot ds) {
        if (ds.data() == null) {
          _controller.model.audioCoin -= callDuration;
          Repository().updateCoin(_controller.model.coin - callDuration);
          leaveChannel();
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
    // if(remoteUid.isEmpty){
    //   await _engine.leaveChannel();
    //   Get.back<dynamic>();
    // }
    await Repository().endVideoCall(callingModel).then((value) async {
      await _engine.leaveChannel().whenComplete(addHistory);
      // Get.back<void>();
    });
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
            onPressed: leaveChannel,
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

  void updateCallStatus(CallStatus callStatus){
    if(callStatus == CallStatus.connecting){
      callStatusText = 'Connecting...';
    }
    if(callStatus == CallStatus.offline){
      callStatusText = 'User is Offline';
    }
    if(callStatus == CallStatus.ringing){
      callStatusText = 'Ringing...';
    }
    if(callStatus == CallStatus.connected){
      callStatusText = 'Connected';
    }
    update();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer){
        if (seconds < 0) {
          timer.cancel();
        } else {
          seconds = seconds + 1;
          callDuration += 1;
          if(_controller.model.audioCoin < callDuration){
            leaveChannel();
            _controller.model.audioCoin = 0;
            Repository().updateCoin(0);
          }
          print(callDuration);
          if (seconds > 59) {
            minutes += 1;
            seconds = 0;
            if (minutes > 59) {
              hours += 1;
              minutes = 0;
            }
          }
        }
        update();
      },

    );
  }
}
