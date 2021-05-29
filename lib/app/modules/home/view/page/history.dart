import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                StringConstants.history,
                style: Styles.boldWhite20,
              ),
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              actions: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ],
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
                              Text('Name, 20 Min', style: Styles.blackBold16),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 2, 0, 0),
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
                                Icons.call_made,
                                size: Dimens.sixTeen,
                                color: Colors.green,
                              ),
                              Text(' Today, 22:20', style: Styles.black12),
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
                      width: Dimens.five,
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
