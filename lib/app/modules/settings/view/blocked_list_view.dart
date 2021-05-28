import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlockedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.blockedList,
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
                            'City, ',
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
                IconButton(icon: const  Icon(Icons.more_vert), onPressed: (){})
              ],
            ),
          ),
        )),
  );
}
