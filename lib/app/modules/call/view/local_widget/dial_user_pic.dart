import 'package:flutter/material.dart';

import '../../../../theme/dimens.dart';
import '../../../../theme/dimens.dart';


class DialUserPic extends StatelessWidget {
  const DialUserPic({
    Key key,
    this.size = 192,
    @required this.image,
  }) : super(key: key);

  final double size;
  final String image;

  @override
  Widget build(BuildContext context) => Container(
      padding: EdgeInsets.all(Dimens.thirty / Dimens.hundred + Dimens.ninetyTwo * size),
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.02),
            Colors.white.withOpacity(0.05)
          ],
          stops: [.5, 1],
        ),
      ),
      child: ClipRRect(
        borderRadius:  BorderRadius.all(Radius.circular(Dimens.hundred)),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
}