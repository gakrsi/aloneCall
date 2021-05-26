import 'package:alonecall/app/modules/payment/controller/payment_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<PaymentController>(
    builder:(_con) => SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: Dimens.screenHeight,
          width: Dimens.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Payment',style: Styles.blackBold18,),
              Text('${_con.data['type']},   ${_con.data['desc']}, ${_con.data['price']}'),
              SizedBox(height: Dimens.hundred,),
              Container(
                margin: EdgeInsets.symmetric(horizontal:Dimens.twenty,vertical: Dimens.five),
                padding: EdgeInsets.symmetric(horizontal:Dimens.twenty,),
                height: Dimens.fifty,
                width: Dimens.screenWidth,
                decoration: BoxDecoration(
                    color: ColorsValue.primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Center(
                  child: TextField(
                    controller: _con.amountEdit,
                    style: Styles.black18,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: ' Enter amount to add',
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimens.fifty,),
              InkWell(
                onTap: (){
                  _con.onClickAdd();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal:Dimens.twenty,vertical: Dimens.five),
                  height: Dimens.fifty,
                  width: Dimens.screenWidth,
                  decoration: BoxDecoration(
                      color: ColorsValue.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text('ADD',style: Styles.black18,)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
