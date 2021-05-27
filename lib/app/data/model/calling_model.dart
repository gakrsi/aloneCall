class CallingModel{
  CallingModel({this.callerImage,this.callerName,this.callerUid});

  CallingModel.fromJson(Map<String,dynamic> data){
    callerUid = data['caller_uid'] as String;
    callerName = data['caller_name'] as String;
    callerImage = data['caller_image'] as String;
    isAudio = data['is_audio'] as bool;
    receiverUid = data['receiver_uid'] as String;
    receiverName = data['caller_name'] as String;
    receiverImage = data['caller_image'] as String;
  }

  String callerUid;
  String callerName;
  String callerImage;
  String receiverUid;
  String receiverName;
  String receiverImage;
  bool isAudio;

  Map<String,dynamic> toMap(CallingModel obj){
    var data = <String,dynamic>{};
    data['caller_uid'] = obj.callerUid;
    data['caller_name'] = obj.callerName;
    data['caller_image'] = obj.callerImage;
    data['is_audio'] = obj.isAudio;
    data['receiver_uid'] = obj.receiverUid;
    data['receiver_name'] = obj.receiverName;
    data['receiver_image'] = obj.receiverImage;
    return data;
  }

}