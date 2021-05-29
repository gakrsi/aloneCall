import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearYouMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Scaffold(
          body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(12.972442, 77.580643), zoom: 15),
      ));
}
