import 'package:flutter/material.dart';

import 'package:alonecall/app/theme/theme.dart';

class OthersProfileDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/img/othersProfileImage.jpg',
                  height: Dimens.screenHeight,
                  width: Dimens.screenWidth,
                  fit: BoxFit.cover),
              Container()
            ],
          ),
        ),
      );
}
