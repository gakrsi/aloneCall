import 'package:alonecall/app/data/model/bank_detail_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {

  AddBankModel addBankModel = AddBankModel();
  TextEditingController amountEdit = TextEditingController();
  bool isLoading = true;
  String confirmAccount = '';
  bool initial = false;

  @override
  void onInit() async {
    isLoading = false;
    update();
    super.onInit();
  }
  void getBankDetail(AddBankModel value) async {
    await Repository().checkBank().then((value)async {
      initial = value;
      if(value){
        await Repository().getBankDetails().then(getBankDetail);
      }
      else{
      }
    });
    addBankModel = value;
    update();

  }
  void onClickAdd(){
    if(addBankModel.accountNumber.isEmpty || addBankModel.ifsc.isEmpty || addBankModel.name.isEmpty){
      Utility.showError('Enter all Details');
    }
    else if  (addBankModel.accountNumber != confirmAccount){
      Utility.showError('Confirm account number is not correct');
    }
    else{
      Utility.showLoadingDialog();
      Repository().addBankDetails(addBankModel).then((value) => Utility.closeDialog());
    }
  }
}
