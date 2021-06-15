import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  HistoryModel(
      {this.callerUid,
      this.callerImage,
      this.callerName,
      this.receiverUid,
      this.receiverName,
      this.receiverImage,
      this.callDuration,
      this.date,
      this.time,
      this.isAudio,
      this.audioCoin,
      this.coin});

  HistoryModel.fromJson(Map<String, dynamic> data) {
    callerName = data['caller_name'] as String;
    callerImage = data['caller_image'] as String;
    callerUid = data['caller_uid'] as String;
    callDuration = data['call_duration'] as int;
    date = data['date'] as Timestamp;
    time = data['time'] as Timestamp;
    receiverUid = data['receiver_uid'] as String;
    receiverName = data['receiver_name'] as String;
    receiverImage = data['receiver_image'] as String;
    isAudio = data['is_audio'] as bool;
    coin = data['coin'] as int;
    audioCoin = data['audio_coin'] as int;
  }

  String callerName;
  String callerImage;
  String callerUid;
  String receiverName;
  String receiverImage;
  String receiverUid;
  int callDuration;
  int coin;
  int audioCoin;
  bool isAudio;
  Timestamp date;
  Timestamp time;

  Map<String, dynamic> toJson(HistoryModel model) {
    var data = <String, dynamic>{};
    data['caller_name'] = model.callerName;
    data['caller_image'] = model.callerImage;
    data['caller_uid'] = model.callerUid;
    data['call_duration'] = model.callDuration;
    data['date'] = model.date;
    data['time'] = model.time;
    data['receiver_name'] = model.receiverName;
    data['receiver_image'] = model.receiverImage;
    data['receiver_uid'] = model.receiverUid;
    data['is_audio'] = model.isAudio;
    data['coin'] = model.coin;
    data['audio_coin'] = model.audioCoin;
    return data;
  }
}
