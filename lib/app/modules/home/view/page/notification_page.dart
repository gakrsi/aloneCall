import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            StringConstants.notification,
            style: Styles.boldWhite20,
          ),
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.fifty,
            child: Row(
              children: [
                Container(
                  height: Dimens.fifty,
                  width: Dimens.fifty,
                  decoration: BoxDecoration(
                      color: ColorsValue.lightGreyColor,
                      borderRadius: BorderRadius.circular(Dimens.fifty)),
                ),
                SizedBox(
                  width: Dimens.ten,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              'Missed a Video Call',
                              style: Styles.blackBold16),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                            child: Icon(
                              Icons.videocam,
                              size: Dimens.sixTeen,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.call_missed,
                            size: Dimens.sixTeen,
                            color: Colors.red,
                          ),
                          Text(
                              ' Today, 22:20',
                              style: Styles.black12),
                        ],
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        )),
  );
}
