import 'package:cloud_firestore/cloud_firestore.dart';

class Withdraw{
  Withdraw({this.date,this.amount,this.status,this.uid});

  Withdraw.fromJson(Map<String,dynamic> data){
    date = data['date'] as Timestamp;
    amount = data['amount'] as double;
    status = data['status'] as String;
    uid = data['uid'] as String;
  }
  Timestamp date;
  double amount;
  String status;
  String uid;

  Map<String,dynamic> toJson(Withdraw model){
    var data = <String,dynamic>{};
    data['date'] = model.date;
    data['amount'] = model.amount;
    data['status'] = model.status;
    data['uid'] = model.uid;
    return data;
  }
}