class HistoryModel{

  HistoryModel({this.callerUid,this.imageUrl,this.callerName,this.isDial,this.callDuration,this.date,this.isMissed,this.time});

  HistoryModel.fromJson(Map<String,dynamic> data){

    callerName = data['caller_ name'] as String;
    imageUrl = data['image_url'] as String;
    callerUid = data['caller_uid'] as String;
    callDuration = data['call_duration'] as String;
    date = data['date'] as String;
    time = data['time'] as String;
    isDial = data['is_dial'] as bool;
    isMissed = data['is_missed'] as bool;
    isAudio = data['is_audio'] as bool;
  }

  String callerName;
  String imageUrl;
  String callerUid;
  String callDuration;
  bool isDial;
  bool isMissed;
  bool isAudio;
  String date;
  String time;

  Map<String,dynamic> toJson(HistoryModel model) {
    var data = <String, dynamic>{};
    data['caller_name'] = model.callerName;
    data['image_url'] = model.imageUrl;
    data['caller_uid'] = model.callerName;
    data['call_duration'] = model.callDuration;
    data['date'] = model.date;
    data['time'] = model.time;
    data['is_dial'] = model.isDial;
    data['is_missed'] = model.isMissed;
    data['is_audio'] = model.isAudio;
    return data;
  }
}