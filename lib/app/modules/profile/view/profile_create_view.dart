import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/global_widgets/form_field_widget.dart';
import 'package:alonecall/app/global_widgets/google_map_widget.dart';
import 'package:alonecall/app/global_widgets/primary_button.dart';
import 'package:alonecall/app/modules/profile/controller/profile_create_controller.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<ProfileCreateController>(
        builder: (_con) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'Profile',
                style: Styles.blackBold18,
              ),
              centerTitle: true,
              elevation: 0,
              leading: const Icon(Icons.arrow_back_outlined)),
          body: _con.model.country ==null
              ?Container(
            child:  Center(
              child: Text('Getting your Location ...',style: Styles.black18,),
            ),
          )
              :SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.twenty),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              3,
                              (index) => InkWell(
                                  onTap: () {
                                    _con.getImage(index + 1);
                                  },
                                  child: circle(_con, index))),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      _texField(_con.nameController, ' Your Name'),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      InkWell(
                          onTap: () {
                            showDateBottomSheet(_con);
                          },
                          child: _dateOfBirth(_con)),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      InkWell(
                          onTap: () {
                            _con.showGenderBottomSheet();
                          },
                          child: _gender(_con)),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      _country(_con),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      _city(_con),
                      SizedBox(
                        height: Dimens.twenty,
                      ),
                      InkWell(
                          onTap: () {
                            _con.showLanguageBottomSheet();
                          },
                          child: _language(_con)),
                      Dimens.boxHeight30,
                      InkWell(
                          onTap: () => _con.validateAndSubmit(),
                          child: PrimaryButton(
                            title: 'Complete',
                            disable: true,
                          )),
                      SizedBox(
                        height: Dimens.twenty,
                      ),

                    ],
                  ),
                ),
                if (_con.pageStatus == PageStatus.loading)
                  Container(
                    height: Dimens.screenHeight,
                    width: Dimens.screenWidth,
                    color: Colors.blueGrey.withOpacity(Dimens.one / Dimens.two),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          ),
        ),
      );

  Widget circle(ProfileCreateController con, int index) =>
      con.profileImageUrl[index].isEmpty
          ? Container(
              height: Dimens.screenWidth / 3 - 20,
              width: Dimens.screenWidth / 3 - 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    )
                  ],
                  border: Border.all(width: 2, color: Colors.white),
                  color: Colors.grey.withOpacity(0.4)),
              child: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: Dimens.fifty,
              ))
          : Container(
              height: Dimens.screenWidth / 3 - 20,
              width: Dimens.screenWidth / 3 - 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    )
                  ],
                  image: DecorationImage(
                      image: NetworkImage(con.profileImageUrl[index]),
                      fit: BoxFit.cover),
                  border: Border.all(width: 2, color: Colors.white),
                  color: Colors.grey.withOpacity(0.4)),
            );

  Widget _texField(TextEditingController controller, String hint) => Container(
        height: 55,
        width: Dimens.screenWidth,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            style: Styles.black18,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: Styles.black18),
          ),
        ),
      );

  void showDateBottomSheet(ProfileCreateController con) {
    Get.bottomSheet<dynamic>(SingleChildScrollView(
      child: Container(
        color: Colors.white,
        height: 360,
        child: Column(
          children: [
            Container(
              height: 300,
              child: CupertinoDatePicker(
                minimumYear: 1930,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime dateTime) {
                  print(dateTime.toString().substring(0,10));
                  con.updateDob(dateTime.toString().substring(0,10));
                  // con.model.dob = dateTime;
                },
              ),
            ),
            InkWell(
              onTap: (){
                Get.back<dynamic>();
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimens.twenty, vertical: Dimens.five),
                height: Dimens.fifty,
                width: Dimens.screenWidth,
                decoration: BoxDecoration(
                    color: ColorsValue.primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                      'Done',
                      style: Styles.boldWhite16,
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget _dateOfBirth(ProfileCreateController con) => Container(
        height: 55,
        width: Dimens.screenWidth,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.5),
            child: Text(con.model.dob)
            ),
      );

  Widget _gender(ProfileCreateController con) => Container(
        height: 55,
        width: Dimens.screenWidth,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.5),
            child: con.model.gender == null
                ? Text(
                    ' Gender',
                    style: Styles.black18,
                  )
                : Text(
                    con.model.gender,
                    style: Styles.black18,
                  )),
      );


  Widget _city(ProfileCreateController con) => Container(
    height: 55,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]),
    child: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 16.5),
        child: con.model.country == null
            ? Text(
          ' City',
          style: Styles.black18,
        )
            : Text(
          con.model.city,
          style: Styles.black18,
        )),
  );


  Widget _country(ProfileCreateController con) => Container(
        height: 55,
        width: Dimens.screenWidth,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.5),
            child: con.model.country == null
                ? Text(
                    ' Country',
                    style: Styles.black18,
                  )
                : Text(
                    con.model.country,
                    style: Styles.black18,
                  )),
      );

  Widget _language(ProfileCreateController con) => Container(
        height: 55,
        width: Dimens.screenWidth,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              )
            ]),
        child: Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.5),
            child: con.model.lang == null
                ? Text(
                    ' Language',
                    style: Styles.black18,
                  )
                : Text(
                    con.model.lang,
                    style: Styles.black18,
                  )),
      );
}
