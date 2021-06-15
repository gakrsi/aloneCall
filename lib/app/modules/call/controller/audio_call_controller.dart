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
  Timer _callingTimer;
  int callingSecond = 0;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  DateTime lastPressedAt;

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

  @override
  void onInit() {
    callingTimer();
    _initEngine();
    checkIsDial();
    checkUserAvailabilityAndBalance();
    super.onInit();
  }

  @override
  void onClose() async {
    _controller.calculateBalance();
    await repo.endVideoCall(callingModel);
    await leaveChannel();
    await Repository().makeUserOnline();
    await callStreamSubscription.cancel();
    if(callingModel.callerUid == repo.uid){
      addHistory();
    }
    await _engine.destroy();
    if(_timer != null){
      _timer.cancel();
    }
    if(_callingTimer != null){
      _callingTimer.cancel();
    }
    super.onClose();
  }

  Future<void> checkUserAvailabilityAndBalance() async {
    var onlineCheck = await repo.checkUserIsOnline(callingModel.receiverUid);
    if (!onlineCheck) {
      updateCallStatus(CallStatus.offline);
    } else {
      updateCallStatus(CallStatus.ringing);
    }
  }

  Future<void> _initEngine() async {
    await repo.makeUserOffline();
    await repo.startVideoCall(callingModel);
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(NetworkConstants.agoraRtcKey));
    _addPostFrameCallback();
    await _addListeners();
    await _engine.enableAudio();
    await _engine.setEnableSpeakerphone(enableSpeakerphone);
    await _engine.setDefaultAudioRoutetoSpeakerphone(false);
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
    await _engine.enableLocalAudio(true);
    await _joinChannel();
  }

  Future<void> _addListeners() async {
    _engine.setEventHandler(RtcEngineEventHandler(
      userJoined: (uid, elapsed) {
        Utility.printDLog('User join the channel');
        startTimer();
        _callingTimer.cancel();
        updateCallStatus(CallStatus.connected);
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        Utility.printDLog('You Join the Channel');
        log('joinChannelSuccess $channel $uid $elapsed');
        isJoined = true;
        Repository().makeUserOffline();
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
      await _controller.reloadProfileDetails();
      await assetsAudioPlayer.pause();
      Get.back<dynamic>();
    });
  }

  void addHistory() {
    HomeController con = Get.find();
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
      ..coin = con.model.coin
      ..audioCoin = con.model.audioCoin
      ..callDuration = callDuration;
    Repository().addHistory(model);
  }

  void checkIsDial() {
    isNotDial = callingModel.receiverUid == repo.uid;
    update();
  }
  
  void _addPostFrameCallback() {
    Utility.printDLog('call stream called in audio screen controller');
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      callStreamSubscription = Repository().videoCallStream().listen((DocumentSnapshot ds) async {
        Utility.printDLog('Listening to call Stream controller');
        if (ds.data() == null) {
          Utility.printDLog('Call is cut by user');
          await leaveChannel();
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

  void switchSpeakerphone() async {
    try{
      await _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
        enableSpeakerphone = !enableSpeakerphone;
        Utility.printDLog('Enable Speaker Phone $enableSpeakerphone');
        update();
      });
    } catch(e){
      Utility.printELog('${e.message}');
    }

    // .catchError((Error err) {
    //   log('setEnableSpeakerphone $err');
    // });
  }

  void playCallingTune(){
      assetsAudioPlayer.open(
        Audio('assets/audio/caller_tune.mp3'),
        autoStart: true,
      );
  }

  void updateCallStatus(CallStatus callStatus) async {
    if (callStatus == CallStatus.connecting) {
      callStatusText = 'Connecting...';
    }
    if (callStatus == CallStatus.offline) {
      callStatusText = 'User is Offline';
    }
    if (callStatus == CallStatus.ringing && callingModel.callerUid == repo.uid) {
      callStatusText = 'Ringing...';
      playCallingTune();
    }
    if (callStatus == CallStatus.connected) {
      await assetsAudioPlayer.pause();
      callStatusText = 'Connected';
      showTimer = true;
    }
    update();
  }

  void callingTimer() async {
    const oneSec = Duration(seconds: 1);
    _callingTimer = Timer.periodic(
      oneSec,
          (Timer timer) async {
        if (callingSecond < 0) {
          timer.cancel();
        } else {
          callingSecond = callingSecond + 1;
          if(callingSecond ==30){
            await repo.endVideoCall(callingModel);
          }
          update();
        }
      },
    );
  }

  void startTimer() async {
    Utility.printDLog('Timer start');
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (seconds < 0) {
          timer.cancel();
        } else {
          seconds = seconds + 1;
          callDuration += 1;
          if(_controller.model.gender == 'Male' && _controller.model.audioCoin <= 0){
            Get.back<dynamic>();
            repo.endVideoCall(callingModel);
          }
          if(callDuration.remainder(30) == 0 && _controller.model.gender == 'Male'){
            repo.updateAudioCoin(_controller.model.audioCoin - 30).then((value){
              _controller.model.audioCoin -= 30;
              if(callingModel.callerUid == repo.uid && _controller.model.gender == 'Male'){
                repo.addAudioCoinToUser(callingModel.receiverUid, 30);
              }
              else{
                repo.addAudioCoinToUser(callingModel.callerUid, 30);
              }
            });
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
