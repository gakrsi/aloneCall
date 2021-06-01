import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// A google map widget which will show the google map with the marker in the
/// center.
class GoogleMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<CommonService>(
    builder: (_interface) => Opacity(
      opacity: _interface.isLatLngUpdated ? 1 : 0,
      child: Stack(
        children: [
          GoogleMap(
            onMapCreated: _interface.onMapCreated,
            initialCameraPosition: const CameraPosition(
              zoom: 15.0,
              target: LatLng(
                0,
                0,
              ),
            ),
            onCameraIdle: () {
              _interface.cameraIdle();
            },
            onCameraMove: _interface.getCameraMoveUpdate,
          ),
          Center(
            child: Icon(
              Icons.location_pin,
              size: Dimens.thirty,
              color: ColorsValue.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}