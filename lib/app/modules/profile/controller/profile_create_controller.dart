import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/theme/theme.dart';

class ProfileCreateController extends GetxController{

  TextEditingController nameController = TextEditingController();

  List<String> genderList = <String>['Male','Female','Gay','Lesbian'];

  List<String> languageList = <String>['English',
    'Hindi',
    'Bengali',
    'Marathi',
    'Telugu',
    'Tamil',
    'Gujarati',
    'Urdu',
    'Kannada',
    'Odia (Oriya)',
    'Malayalam',
    'Punjabi',
    'Bodo',
    'Dogri',
    'Kashmiri',
    'Konkani',
    'Maithili',
    'Manipuri',
    'Nepali',
    'Sanskrit',
    'Santali Language',
   ' Sindhi',
    'Assamese'
  ];

  String gender = '';
  String language = '';

  void showGenderBottomSheet(){
    Get.bottomSheet<void>(
        Container(
          height: 150,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
                children: List.generate(genderList.length, (index) => InkWell(
                  onTap: (){
                    gender = genderList[index];
                    update();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(30),
                        color: gender == genderList[index]?ColorsValue.primaryColor:Colors.white,
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
                        padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
                        child: Text(genderList[index],style: Styles.grey16,)
                    ),
                  ),
                ))
            ),
          ),
        ),
        backgroundColor: Colors.white
    );
  }

  void showLanguageBottomSheet(){
    Get.bottomSheet<void>(
        Container(
          height: 400,
          width: Dimens.screenWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: List.generate(languageList.length, (index) => InkWell(
                    onTap: (){
                      language = languageList[index];
                      update();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Colors.grey.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(30),
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
                          padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
                          child: Text(languageList[index],style: Styles.grey16,)
                      ),
                    ),
                  ))
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white
    );
  }

}