import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/dimens.dart';



class DialButton extends StatelessWidget {
  const DialButton({
    Key key,
    @required this.iconSrc,
    @required this.text,
    @required this.press,
    @required this.flag
  }) : super(key: key);

  final String iconSrc, text;
  final VoidCallback press;
  final bool flag;

  @override
  Widget build(BuildContext context) => Container(
      color: flag?Colors.transparent:Colors.red,
      width: Dimens.hundred,
      child: FlatButton(
        padding: EdgeInsets.symmetric(
          vertical: Dimens.twenty,
        ),
        onPressed: press,
        child: Column(
          children: [
            SvgPicture.asset(
              iconSrc,
              color: Colors.white,
              height: Dimens.thirtySix,
            ),
            SizedBox(height: Dimens.twenty,),
            Text(
              text,
              style: Styles.white14
            )
          ],
        ),
      ),
    );
}