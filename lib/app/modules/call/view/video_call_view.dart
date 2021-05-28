import 'package:alonecall/app/global_widgets/circular_photo.dart';
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
                child: _controller.remoteUid.isEmpty
                    ? Stack(
                        children: [
                          RtcLocalView.SurfaceView(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: Dimens.eighty,
                                ),
                                circularPhoto(
                                    imageUrl: _controller.isNotDial
                                        ? _controller.callingModel.callerImage
                                        : _controller
                                            .callingModel.receiverImage),
                                SizedBox(
                                  height: Dimens.ten,
                                ),
                                Text(
                                    _controller.isNotDial
                                        ? _controller.callingModel.callerName
                                        : _controller.callingModel.receiverName,
                                    style: Styles.boldWhite16),
                                SizedBox(
                                  height: Dimens.ten,
                                ),
                                Text(
                                  _controller.callStatusText,
                                  style: const TextStyle(color: Colors.white60),
                                ),
                              ],
                            ),
                          ),
                          _controller.toolbar()
                        ],
                      )
                    : _controller.isReceiverBig
                        ? receiverBigView(_controller)
                        : callerBigView(_controller)),
          ));

  Widget callerBigView(VideoCallController con) => Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                con.changeSize();
              },
              child: Container(
                margin: EdgeInsets.all(Dimens.twenty),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.ten)),
                height: Dimens.hundred + Dimens.twenty,
                width: Dimens.hundred + Dimens.twenty,
                child: RtcRemoteView.SurfaceView(
                  uid: con.remoteUid[0],
                ),
              ),
            ),
          ),
          con.toolbar()
        ],
      );

  Widget receiverBigView(VideoCallController con) => Stack(
        children: [
          RtcRemoteView.SurfaceView(
            uid: con.remoteUid[0],
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                con.changeSize();
              },
              child: Container(
                margin: EdgeInsets.all(Dimens.twenty),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.ten)),
                height: Dimens.hundred + Dimens.twenty,
                width: Dimens.hundred + Dimens.twenty,
                child: RtcLocalView.SurfaceView(),
              ),
            ),
          ),
          con.toolbar()
        ],
      );
}
