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
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioCallController extends GetxController {
  int callDuration = 0;
  bool showTimer = false;
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  final HomeController _controller = Get.find();
  bool isNotDial;
  CallingModel callingModel = Get.arguments as CallingModel;
  Repository repo = Repository();
  String callStatusText = 'Connecting...';
  RtcEngine _engine;
  String channelId = 'channelId';
  bool isJoined = false;
  bool openMicrophone = true;
  bool enableSpeakerphone = false;
  bool playEffect = false;
  bool enableInEarMonitoring = false;
  double recordingVolume = 0, playbackVolume = 0, inEarMonitoringVolume = 0;
  StreamSubscription callStreamSubscription;
  final assetsAudioPlayer = AssetsAudioPlayer();



  Future<void> checkUserAvailabilityAndBalance() async {
    var onlineCheck = await repo.checkUserIsOnline(callingModel.receiverUid);
    // var busyCheck = await repo.checkUserOnCall(callingModel.receiverUid);
    if (!onlineCheck) {
      updateCallStatus(CallStatus.offline);
    } else {
      updateCallStatus(CallStatus.ringing);
    }
  }

  Future<void> _initEngine() async {
    await repo.startVideoCall(callingModel);
    _engine = await RtcEngine.createWithConfig(
        RtcEngineConfig(NetworkConstants.agoraRtcKey));
    _addPostFrameCallback();
    await _addListeners();
    await _engine.enableAudio();
    await _engine.setDefaultAudioRoutetoSpeakerphone(false);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _engine.enableLocalAudio(true);
    await _joinChannel();
  }

  Future<void> _addListeners() async {
    _engine.setEventHandler(RtcEngineEventHandler(
      userJoined: (uid, elapsed) {
        startTimer();
        updateCallStatus(CallStatus.connected);
      },
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

  Future<void> _joinChannel() async {
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
      Utility.printDLog('Leaving channel');
      await _engine.leaveChannel();
      Get.back<dynamic>();
    });
  }

  void addHistory() {
    var model = HistoryModel()
      ..callerName = callingModel.callerName
      ..callerUid = callingModel.callerUid
      ..callerImage = callingModel.callerImage
      ..receiverUid = callingModel.receiverUid
      ..receiverName = callingModel.receiverName
      ..receiverImage = callingModel.receiverImage
      ..isAudio = true
      ..date = Timestamp.now()
      ..time = Timestamp.now()
      ..callDuration = callDuration;
    Repository().addHistory(model);
  }

  void checkIsDial() {
    isNotDial = callingModel.receiverUid == repo.uid;
    update();
  }

  @override
  void onInit() {
    _initEngine();
    checkIsDial();
    checkUserAvailabilityAndBalance();
    super.onInit();
  }

  @override
  void onClose() {
    callStreamSubscription.cancel();
    addHistory();
    _engine.destroy();
    if(_timer != null){
      _timer.cancel();
    }
    super.onClose();
  }

  void _addPostFrameCallback() {
    Utility.printDLog('call stream called in audio screen');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription = Repository().videoCallStream().listen((DocumentSnapshot ds) {
        Utility.printDLog('Listening to call Stream');
        if (ds.data() == null) {
          _controller.model.audioCoin -= callDuration;
          Repository().updateAudioCoin(_controller.model.audioCoin - callDuration);
          leaveChannel();
        }
      });
    });
  }

  void switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      openMicrophone = !openMicrophone;
      update();
    }).catchError((Error err) {
      log('enableLocalAudio $err');
    });
  }

  void switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      enableSpeakerphone = !enableSpeakerphone;
      update();
    }).catchError((Error err) {
      log('setEnableSpeakerphone $err');
    });
  }

  void _onChangeInEarMonitoringVolume(double value) {
    inEarMonitoringVolume = value;
    update();
    _engine.setInEarMonitoringVolume(value.toInt());
  }

  void _toggleInEarMonitoring(bool value) {
    enableInEarMonitoring = value;
    update();
    _engine.enableInEarMonitoring(value);
  }



  void playCallingTune(){
      assetsAudioPlayer..open(
        Audio('assets/audio/ringing.mp3'),
        autoStart: true,
      )
        ..currentLoopMode
        ..setLoopMode(LoopMode.single);
  }

  void updateCallStatus(CallStatus callStatus) {
    if (callStatus == CallStatus.connecting) {
      callStatusText = 'Connecting...';
    }
    if (callStatus == CallStatus.offline) {
      callStatusText = 'User is Offline';
    }
    if (callStatus == CallStatus.ringing) {
      callStatusText = 'Ringing...';
      playCallingTune();
    }
    if (callStatus == CallStatus.connected) {
      assetsAudioPlayer.pause();
      callStatusText = 'Connected';
      showTimer = true;
    }
    update();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds < 0) {
          timer.cancel();
        } else {
          seconds = seconds + 1;
          callDuration += 1;
          if(_controller.model.audioCoin < callDuration){
            leaveChannel();
            _controller.model.coin = 0;
            Repository().updateAudioCoin(0);
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
          update();
        }
      },
    );
  }
}
