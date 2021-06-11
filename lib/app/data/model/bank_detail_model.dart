class AddBankModel{

  AddBankModel({this.accountNumber,this.ifsc,this.name,this.nickName,this.number});

  AddBankModel.fromJson(Map<String,dynamic> data){
    accountNumber = data['account'] as String;
    ifsc = data['ifsc'] as String;
    name = data['name'] as String;
    number = data['number'] as String;
    nickName = data['nick_name'] as String;
  }
  String accountNumber = '';
  String ifsc = '';
  String name = '';
  String number = '';
  String nickName = '';

  Map<String,dynamic> toMap(AddBankModel model){
    var data = <String,dynamic>{};
    data['account'] = model.accountNumber;
    data['ifsc'] = model.ifsc;
    data['name'] = model.name;
    data['number'] = model.number;
    data['nick_name'] = model.nickName;
    return data;
  }
}