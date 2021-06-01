import 'package:fluster/fluster.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
class MapMarker extends Clusterable {

  MapMarker({
    @required this.id,
    @required this.position,
    @required this.icon,
    bool isCluster = false,
    int clusterId,
    int pointsSize,
    String childMarkerId,
  }) : super(
    markerId: id,
    latitude: position.latitude,
    longitude: position.longitude,
    isCluster: isCluster,
    clusterId: clusterId,
    pointsSize: pointsSize,
    childMarkerId: childMarkerId,
  );
  final String id;
  final LatLng position;
  BitmapDescriptor icon;
  Marker toMarker() => Marker(
    markerId: MarkerId(id),
    position: LatLng(
      position.latitude,
      position.longitude,
    ),
    icon: icon,
  );
}