import 'package:flutter/material.dart';

import 'package:alonecall/app/theme/theme.dart';




class ProfileCreateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) => circle()),
          )
        ],
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
  );
}
