import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  ProfileModel(
      {this.uid,
      this.country,
      this.gender,
      this.lang,
      this.name,
      this.dob,
      this.city,
      this.long,
      this.lat,
      this.profileImageUrl,
      this.audioCoin,
      this.coin,
      this.online});

  ProfileModel.fromJson(Map<String, dynamic> data) {
    name = data['name'] as String;
    dob = data['dob'] as String;
    lang = data['lang'] as String;
    gender = data['gender'] as String;
    country = data['country'] as String;
    uid = data['uid'] as String;
    coin = data['coin'] as int;
    profileImageUrl = data['profile_image_url'] as List<dynamic>;
    online = data['online'] as bool;
    audioCoin = data['audio_coin'] as int;
    city = data['city'] as String;
    lat = data['lat'] as double;
    long = data['long'] as double;
    time = data['time'] as Timestamp;
  }

  String name;
  String dob;
  String lang;
  String gender;
  String city;
  String country;
  String uid;
  int coin;
  int audioCoin;
  List<dynamic> profileImageUrl;
  bool online;
  double lat;
  double long;
  Timestamp time;

  Map<String, dynamic> toMap(ProfileModel obj) {
    var data = <String, dynamic>{};
    data['name'] = obj.name;
    data['dob'] = obj.dob;
    data['lang'] = obj.lang;
    data['gender'] = obj.gender;
    data['country'] = obj.country;
    data['uid'] = obj.uid;
    data['coin'] = obj.coin;
    data['audio_coin'] = obj.audioCoin;
    data['profile_image_url'] = obj.profileImageUrl;
    data['lat'] = obj.lat;
    data['long'] = obj.long;
    data['city'] = obj.city;
    data['time'] = obj.time;
    return data;
  }
}
