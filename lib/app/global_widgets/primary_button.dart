import 'package:flutter/material.dart';

import 'package:alonecall/app/theme/theme.dart';


class PrimaryButton extends StatelessWidget {
  PrimaryButton({this.title,this.disable});
  final String title;
  final bool disable;
  @override
  Widget build(BuildContext context) => Container(
      height: Dimens.fiftyFive,
      width: Dimens.screenWidth,
      decoration: BoxDecoration(
          color: !disable?ColorsValue.primaryColor.withOpacity(0.2):ColorsValue.primaryColor,
          borderRadius: BorderRadius.circular(3)
      ),
      child: Center(child: Text(title,style: Styles.boldWhite23,)),
    );
}
