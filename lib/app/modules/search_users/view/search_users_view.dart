import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
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
                          Text(StringConstants.name, style: Styles.blackBold16),
                          Text('age', style: Styles.blackBold16),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Language, ',
                            style: Styles.grey14,
                          ),
                          Text(
                            'Country',
                            style: Styles.grey14,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    height: Dimens.fourty,
                    width: Dimens.fourty,
                    decoration: BoxDecoration(
                        color: ColorsValue.primaryColor,
                        borderRadius: BorderRadius.circular(Dimens.fifty)),
                    child: Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: Dimens.twenty,
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimens.ten,
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    height: Dimens.fourty,
                    width: Dimens.fourty,
                    decoration: BoxDecoration(
                        color: ColorsValue.primaryColor,
                        borderRadius: BorderRadius.circular(Dimens.fifty)),
                    child: Icon(
                      Icons.videocam,
                      color: Colors.white,
                      size: Dimens.twenty,
                    ),
                  ),
                ),
                const Divider()
              ],
            ),
          ),
        )),
      );
}
