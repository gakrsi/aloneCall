import 'package:alonecall/app/global_widgets/primary_button.dart';
import 'package:alonecall/app/modules/payment/controller/payment_controller.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<PaymentController>(
        builder: (_con) => SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                StringConstants.addBank,
                style: Styles.boldWhite20,
              ),
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: _con.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: Dimens.screenHeight,
                    width: Dimens.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: Dimens.twelve,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                          ),
                          height: Dimens.fifty,
                          width: Dimens.screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Center(
                            child: TextFormField(
                              initialValue: _con.addBankModel.accountNumber ?? ' ',
                              onChanged: (value) =>
                                  _con.addBankModel.accountNumber = value,
                              style: Styles.black18,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: ' Account number',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                          ),
                          height: Dimens.fifty,
                          width: Dimens.screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Center(
                            child: TextFormField(
                              initialValue: _con.addBankModel.accountNumber ?? ' ',
                              onChanged: (value) => _con.confirmAccount = value,
                              style: Styles.black18,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: ' Confirm account number',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                          ),
                          height: Dimens.fifty,
                          width: Dimens.screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Center(
                            child: TextFormField(
                              initialValue: _con.addBankModel.ifsc ?? ' ',
                              onChanged: (value) =>
                                  _con.addBankModel.ifsc = value,
                              style: Styles.black18,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  hintText: ' IFSC', border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                          ),
                          height: Dimens.fifty,
                          width: Dimens.screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Center(
                            child: TextFormField(
                              initialValue: _con.addBankModel.name ?? ' ',
                              onChanged: (value) =>
                                  _con.addBankModel.name = value,
                              style: Styles.black18,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  hintText: ' Account holder name',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                          ),
                          height: Dimens.fifty,
                          width: Dimens.screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Center(
                            child: TextFormField(
                              initialValue: _con.addBankModel.number ?? ' ',
                              onChanged: (value) =>
                                  _con.addBankModel.number = value,
                              style: Styles.black18,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: ' Phone number (optional)',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimens.twenty, vertical: Dimens.five),
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimens.twenty,
                          ),
                          height: Dimens.fifty,
                          width: Dimens.screenWidth,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ]),
                          child: Center(
                            child: TextFormField(
                              initialValue: _con.addBankModel.nickName ?? ' ',
                              onChanged: (value) =>
                                  _con.addBankModel.nickName = value,
                              style: Styles.black18,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  hintText: ' Nickname (optional)',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimens.fifty,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            _con.onClickAdd();
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimens.twenty,
                                  vertical: Dimens.five),
                              height: Dimens.fifty,
                              width: Dimens.screenWidth,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.4)),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    )
                                  ]),
                              child: PrimaryButton(
                                title: 'Done',
                                disable: true,
                              )),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      );
}
