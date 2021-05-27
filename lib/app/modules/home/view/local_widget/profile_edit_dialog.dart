import 'package:alonecall/app/data/model/profile_model.dart';
import 'package:alonecall/app/global_widgets/slider.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';

class ProfileEditDialog extends StatelessWidget {

  ProfileEditDialog({this.model});
  final ProfileModel model;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
      body: SizedBox(
        height: Dimens.screenHeight,
        child: Padding(
          padding: Dimens.edgeInsets15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: Dimens.screenHeight-415,
                width: Dimens.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  children: [
                        ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SliderCaro(sliderItem: model.profileImageUrl,)),
                      ],
                ),
              ),
              SizedBox(height: Dimens.twentyFive,),
              InkWell(
                onTap: (){
                  RoutesManagement.goToOProfileEdit(model);
                },
                child: Container(
                  height: Dimens.fifty,
                  width: Dimens.screenWidth,
                  decoration: BoxDecoration(
                      color: ColorsValue.primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                      child: Text(
                        'Edit Profile',
                        style: Styles.black18,
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
}
