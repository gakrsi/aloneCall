import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/colors_value.dart';
import 'package:alonecall/app/theme/dimens.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: const Icon(
            Icons.arrow_back,
          ),
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
              InkWell(
                onTap: (){
                  RoutesManagement.goToBlockedListScreen();
                },
                child: Container(
                height: 50,
                width: Dimens.screenWidth - 40,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        StringConstants.blockedList,
                        style: Styles.blackBold16,
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
            ),
              ),

            const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 50,
                    width: Dimens.screenWidth - 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            StringConstants.rateUs,
                            style: Styles.blackBold16,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 50,
                    width: Dimens.screenWidth - 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            StringConstants.aboutUs,
                            style: Styles.blackBold16,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blueGrey,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                RaisedButton(
                    onPressed: () {
                      Repository().logout();
                    },
                    color: ColorsValue.primaryColor,
                    child: Text(
                      StringConstants.logOut,
                      style: Styles.boldWhite16,
                    )),
              ],
            ),
          ),
        ),
      );
}
