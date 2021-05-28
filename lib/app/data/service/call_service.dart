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
  void playCallingTune(){
    AssetsAudioPlayer.newPlayer().open(
      Audio('assets/audio/RingTone.mp3'),
      autoStart: true,
    );
  }
  void playIncomingRingTune(){
    AssetsAudioPlayer.newPlayer().open(
      Audio('assets/audio/ringing.mp3'),
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

  void _addPostFrameCallback() {
    updateCallStatusDisConnected();
    Utility.printDLog('Stream Listen to Incoming Call');
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription =
          Repository().videoCallStream().listen((DocumentSnapshot ds) {
        if (ds.exists) {
          var callingModel = CallingModel.fromJson(ds.data() as Map<String, dynamic>);
          if ((callingModel.callerUid != Repository().uid) && !callReceived) {

            Utility.showCallPickupDialog(callingModel);
            Utility.printDLog('${ds.data()}');
          }
        }
        else{
          updateCallStatusDisConnected();
          Utility.closeDialog();
        }
      });
    });
  }
}

//         var model = CallingModel.fromJson(
//             snapshot.data.docs[0].data() as Map<String, dynamic>);
//         if (model.callerUid == Repository().uid) {
//           return Scaffold(
//             backgroundColor: Colors.white,
//             bottomNavigationBar: BottomNavigation(),
//             body: IndexedStack(
//               index: _controller.currentTab,
//               children: [
//                 HomePage(),
//                 NearYouMapView(),
//                 HistoryPage(),
//                 RandomVideoCallView(),
//                 ProfileView(),
//               ],
//             ),
//           );
//         }
//
//         return PickUpScreen(
//           callingModel: model,
//         );
//       },
