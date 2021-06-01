import 'package:google_maps_flutter/google_maps_flutter.dart';

class AvatarModel{
  AvatarModel(this.latLng,this.uid,this.imageUrl);

  String imageUrl;
  String uid;
  LatLng latLng;
}