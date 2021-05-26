import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  Razorpay razorPay = Razorpay();
  Map<String, dynamic> options;
  ProfileModel model = Get.arguments[0] as ProfileModel;
  int amount;
  TextEditingController amountEdit = TextEditingController()
    ..text = Get.arguments[1];
  Map<String, dynamic> data = Get.arguments[2];
  @override
  void onInit() {
    model = Get.arguments[0] as ProfileModel;
    _initializePayment();
    super.onInit();
  }

  void _initializePayment() {
    razorPay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void checkout() {
    options = <String, dynamic>{
      'key': 'rzp_test_HGESD2Chi4Y3yy',
      'amount': amount * 100,
      'name': 'AloneCall.com',
      'description': 'Coins',
      'prefill': {'contact': '${model.name}', 'email': '${model.country}'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorPay.open(options);
    } catch (e) {
      Utility.printDLog('$e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    data['is_video'] as bool
        ? Repository().addVideoCoin(data['amount'] + model.coin)
        : Repository().addAudioCoin(data['amount'] + model.coin);
    Utility.showError('SUCCESS: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Utility.showError('ERROR: ${response.code} - ${response.message}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utility.showError('EXTERNAL_WALLET: ${response.walletName}');
  }

  void onClickAdd() {
    if (amountEdit.text.isNotEmpty && amountEdit.text.isNum) {
      amount = int.parse(amountEdit.text);
      checkout();
    } else {
      Utility.showError('Enter correct amount');
    }
  }
}
