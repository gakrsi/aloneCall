import 'package:alonecall/app/modules/call/controller/call_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:get/get.dart';

class VideoCallView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: _renderVideo(),
      );

  Widget _renderVideo() => GetBuilder<VideoCallController>(
      builder: (_controller) => SizedBox(
            height: Dimens.screenHeight,
            width: Dimens.screenWidth,
            child: Stack(
              children: [
                RtcLocalView.SurfaceView(),
                Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.of(_controller.remoteUid.map(
                        (e) => GestureDetector(
                          onTap: () => _controller.switchCam(),
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: RtcRemoteView.SurfaceView(
                              uid: e,
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                ),
                _controller.toolbar()
              ],
            ),
          ));
}
