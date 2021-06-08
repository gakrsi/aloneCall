import 'package:alonecall/app/data/model/bank_detail_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {

  AddBankModel addBankModel = AddBankModel();
  TextEditingController amountEdit = TextEditingController();

  void onClickAdd(){
    if(addBankModel.accountNumber == null || addBankModel.ifsc == null || addBankModel.name == null){
      Utility.showError('Enter all Details');
    }
    else if  (addBankModel.accountNumber == amountEdit.text){
      Utility.showError('Confirm account number is not correct');
    }
    else{
      Repository().addBankDetails(addBankModel);
    }
  }
}
