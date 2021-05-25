import 'package:alonecall/app/modules/call/controller/video_call_controller.dart';
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
      builder: (_controller) => SafeArea(
            child: SizedBox(
              height: Dimens.screenHeight,
              width: Dimens.screenWidth,
              child: _controller.isReceiverBig
                  ? Stack(
                      children: [
                        _controller.remoteUid.isNotEmpty
                            ? Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    _controller.changeSize();
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 120,
                                    width: 120,
                                    child: RtcRemoteView.SurfaceView(
                                      uid: _controller.remoteUid[0],
                                    ),
                                  ),
                                ),
                              )
                            : RtcLocalView.SurfaceView(),
                        _controller.toolbar()
                      ],
                    )
                  : Stack(
                      children: [
                        // RtcLocalView.SurfaceView(),
                        _controller.remoteUid.isNotEmpty
                            ? RtcRemoteView.SurfaceView(
                                uid: _controller.remoteUid[0],
                              )
                            : RtcLocalView.SurfaceView(),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              _controller.changeSize();
                            },
                            child: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                height: 120,
                                width: 120,
                                child: RtcLocalView.SurfaceView()),
                          ),
                        ),
                        _controller.toolbar()
                      ],
                    ),
            ),
          ));
}
