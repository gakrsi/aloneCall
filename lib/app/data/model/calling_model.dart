class CallingModel{
  CallingModel({this.callerImage,this.callerName,this.callerUid,this.isDial});

  CallingModel.fromJson(Map<String,dynamic> data){
    callerName = data['caller_name'] as String;
    callerUid = data['caller_uid'] as String;
    callerImage = data['caller_image'] as String;
    isDial = data['is_dial'] as bool;
    isAudio = data['is_audio'] as bool;
  }

  String callerName;
  String callerUid;
  String callerImage;
  bool isDial;
  bool isAudio;

  Map<String,dynamic> toMap(CallingModel obj){
    var data = <String,dynamic>{};
    data['caller_name'] = obj.callerName;
    data['caller_uid'] = obj.callerUid;
    data['caller_image'] = obj.callerImage;
    data['is_dial'] = obj.isDial;
    data['is_audio'] = obj.isAudio;
    return data;
  }

}