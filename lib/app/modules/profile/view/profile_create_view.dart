import 'package:alonecall/app/data/enum.dart';
import 'package:alonecall/app/global_widgets/primary_button.dart';
import 'package:alonecall/app/modules/profile/controller/profile_create_controller.dart';
import 'package:flutter/material.dart';

import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';




class ProfileCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetBuilder<ProfileCreateController>(
    builder:(_con)=> Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile',style: Styles.blackBold18,),
        centerTitle: true,
        elevation: 0,
        leading: Icon(Icons.arrow_back_outlined)
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal:Dimens.twenty),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) => InkWell(
                        onTap: (){
                          _con.getImage();
                        },
                          child: circle())),
                    ),
                  ),
                  SizedBox(height: Dimens.twenty,),
                  _texField(_con.nameController,' Name'),
                  SizedBox(height: Dimens.twenty,),
                  _dateOfBirth(),
                  SizedBox(height: Dimens.twenty,),
                  InkWell(
                    onTap: (){
                      _con.showGenderBottomSheet();
                    },
                      child: _gender(_con)
                  ),
                  SizedBox(height: Dimens.twenty,),
                  InkWell(
                    onTap: (){
                      _con.showCountryBottomSheet();
                    },
                      child: _country(_con)),
                  SizedBox(height: Dimens.twenty,),
                  InkWell(
                    onTap: (){
                      _con.showLanguageBottomSheet();
                    },
                      child: _language(_con)),
                  SizedBox(height: Dimens.twenty,),
                  InkWell(
                    onTap: ()=> _con.validateAndSubmit(),
                      child: PrimaryButton(title: 'Complete',disable: true,))
                ],
              ),
            ),
            if(_con.pageStatus == PageStatus.loading)
              Container(
                height: Dimens.screenHeight,
                width:Dimens.screenWidth,
                color: Colors.blueGrey.withOpacity(Dimens.one/Dimens.two),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        ),
      ),
    ),
  );

  Widget circle()=>Container(
    height: Dimens.screenWidth/3 - 20,
    width: Dimens.screenWidth/3 - 20,
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
      border: Border.all(width: 2,color: Colors.white),
      color: Colors.grey.withOpacity(0.4)
    ),
    child: Icon(Icons.add_circle_outline,color: Colors.white,size: Dimens.fifty,),
  );

  Widget _texField(TextEditingController controller,String hint)=> Container(
    height: 55,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
      border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
      borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: Styles.black18,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: Styles.grey16
        ),
      ),
    ),
  );

  Widget _dateOfBirth()=>Container(
    height: 55,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text('Your Birthday',style: Styles.grey16,))
    ),
  );

  Widget _gender(ProfileCreateController con)=>Container(
    height: 55,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]
    ),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: con.model.gender == null?Text(' Gender',style: Styles.grey16,):Text(con.model.gender,style: Styles.grey16,))
    ),
  );

  Widget _country(ProfileCreateController con)=>Container(
    height: 55,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]
    ),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: con.model.country == null?Text(' Country',style: Styles.grey16,):Text(con.model.country,style: Styles.grey16,))
    ),
  );

  Widget _language(ProfileCreateController con)=>Container(
    height: 55,
    width: Dimens.screenWidth,
    decoration: BoxDecoration(
        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]
    ),
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: con.model.lang == null?Text(' Language',style: Styles.grey16,):Text(con.model.lang,style: Styles.grey16,))
    ),
  );


}
