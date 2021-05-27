class ProfileModel {
  ProfileModel(
      {this.uid, this.country, this.gender, this.lang, this.name, this.dob});

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
  }

  String name;
  String dob;
  String lang;
  String gender;
  String country;
  String uid;
  int coin;
  int audioCoin;
  List<dynamic> profileImageUrl;
  bool online;

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
    return data;
  }
}
