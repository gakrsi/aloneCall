class CallingModel{
  CallingModel({this.callerImage,this.callerName,this.callerUid});

  CallingModel.fromJson(Map<String,dynamic> data){
    callerName = data['caller_name'] as String;
    callerUid = data['caller_uid'] as String;
    callerImage = data['caller_image'] as String;
    isAudio = data['is_audio'] as bool;
    receiverUid = data['receiver_uid'] as String;
  }

  String callerName;
  String callerUid;
  String callerImage;
  String receiverUid;
  bool isAudio;

  Map<String,dynamic> toMap(CallingModel obj){
    var data = <String,dynamic>{};
    data['caller_name'] = obj.callerName;
    data['caller_uid'] = obj.callerUid;
    data['caller_image'] = obj.callerImage;
    data['is_audio'] = obj.isAudio;
    data['receiver_uid'] = obj.receiverUid;
    return data;
  }

}