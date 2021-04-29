import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// A chunk of location details needed
class LocationData extends Equatable {
  LocationData(
      {@required this.placeName,
        @required this.addressLine1,
        @required this.addressLine2,
        @required this.area,
        @required this.city,
        @required this.postalCode,
        @required this.country,
        @required this.latitude,
        @required this.longitude});

  final String placeName;
  final String addressLine1;
  final String addressLine2;
  final String area;
  final String city;
  final String postalCode;
  final String country;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [
    placeName,
    addressLine1,
    addressLine2,
    area,
    city,
    postalCode,
    country,
    latitude,
    longitude
  ];

  @override
  bool get stringify => true;
}