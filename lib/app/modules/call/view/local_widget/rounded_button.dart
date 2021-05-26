import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../theme/dimens.dart';
import '../../../../theme/dimens.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.size = 64,
    @required this.iconSrc,
    this.color = Colors.white,
    this.iconColor = Colors.black,
    @required this.press,
  }) : super(key: key);

  final double size;
  final String iconSrc;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: size,
        width: size,
        child: FlatButton(
          padding: EdgeInsets.all(Dimens.fifteen / Dimens.sixtyFour * size),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Dimens.hundred)),
          ),
          color: color,
          onPressed: press,
          child: SvgPicture.asset(iconSrc, color: iconColor),
        ),
      );
}
