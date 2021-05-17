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
        title: Text('Profile',style: Styles.black18,),
        centerTitle: true,
        elevation: 0,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Dimens.thirty,
              width: Dimens.thirty,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsValue.primaryColor.withOpacity(0.1),
                border: Border.all(color: ColorsValue.primaryColor,width: 1)
              ),
                child: Icon(Icons.arrow_back_outlined,size: Dimens.twentyFive,color: ColorsValue.primaryColor)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:Dimens.twenty),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => circle()),
              ),
              SizedBox(height: Dimens.twenty,),
              _texField(_con.nameController,' Name'),
              SizedBox(height: Dimens.twenty,),
              _dateOfBirth(),
              SizedBox(height: Dimens.twenty,),
              _gender(),
              SizedBox(height: Dimens.twenty,),
              _country(),
              SizedBox(height: Dimens.twenty,),
              _language(),
              SizedBox(height: Dimens.twenty,),
              PrimaryButton(title: 'Complete',disable: true,)
            ],
          ),
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
            color: Colors.grey.withOpacity(0.2),
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
      child: Text(' Date Of Birth',style: Styles.grey16,)
    ),
  );

  Widget _gender()=>Container(
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
        child: Text(' Gender',style: Styles.grey16,)
    ),
  );

  Widget _country()=>Container(
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
        child: Text(' Country',style: Styles.grey16,)
    ),
  );

  Widget _language()=>Container(
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
        child: Text(' Language',style: Styles.grey16,)
    ),
  );
}
