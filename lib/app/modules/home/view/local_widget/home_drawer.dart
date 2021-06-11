
import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/asset_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawer() => GetBuilder<HomeController>(
    builder: (_controller) => Container(
      width: 230,
      child: Drawer(
            child: _controller.model.dob == null
                ? ListView(
              children: [
                Container(
                  height: Dimens.hundred*2.5,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image:  DecorationImage(
                      image: AssetConstants.loading,
                      fit: BoxFit.cover
                    )
                  ),
                ),
                const Divider(),
                Container(
                  height: Dimens.eighty,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          image: AssetConstants.loading,
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const Divider(),
                Container(
                  height: Dimens.eighty,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          image: AssetConstants.loading,
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const Divider(),
                Container(
                  height: Dimens.eighty,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          image: AssetConstants.loading,
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const Divider(),
                Container(
                  height: Dimens.eighty,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          image: AssetConstants.loading,
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const Divider(),
                Container(
                  height: Dimens.eighty,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          image: AssetConstants.loading,
                          fit: BoxFit.cover
                      )
                  ),
                ),
                const Divider(),
                Container(
                  height: Dimens.eighty,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image:  DecorationImage(
                          image: AssetConstants.loading,
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ],
            )
                : ListView(
                    children: [
                      UserAccountsDrawerHeader(
                        decoration: const BoxDecoration(color: Colors.black),
                        accountName: Text(
                          '${_controller.model.name}, ${DateTime.now().year - int.parse(_controller.model.dob.substring(0, 4))}',
                          style: Styles.boldWhite18,
                        ),
                        accountEmail: Text(
                            '${_controller.model.city}, ${_controller.model.country}',
                            style: Styles.white16),
                        currentAccountPicture: InkWell(
                          onTap: () => RoutesManagement.goToOProfileEdit(
                              _controller.model),
                          child: CircleAvatar(
                            child: circularPhoto(
                                imageUrl: _controller.model.profileImageUrl[0]
                                    as String),
                          ),
                        ),
                        otherAccountsPictures: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            onPressed: () => RoutesManagement.goToOProfileEdit(
                                _controller.model),
                          )
                        ],
                      ),

                      ListTile(
                        title: Text(
                          'Audio Sec',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        trailing: Text('${_controller.model.audioCoin}   '),
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          'Video Sec',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        trailing: Text('${_controller.model.coin}   '),
                        leading: const Icon(
                          Icons.videocam,
                          color: Colors.black,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          'Blocked User',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        leading: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                        onTap: RoutesManagement.goToBlockedListScreen,
                      ),
                      const Divider(),
                      _controller.model.gender == 'Male'?const SizedBox(height: 0,):
                      ListTile(
                        title: Text(
                          'Bank Account',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                        leading: const Icon(
                          Icons.account_balance_wallet,
                          color: Colors.black,
                        ),
                        onTap: (){
                          RoutesManagement.goToPayment();
                        },
                      ),
                      _controller.model.gender == 'Male'?const SizedBox(height: 0,):const Divider(),
                      ListTile(
                        title: Text(
                          'Contact Us',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        leading: const Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                        onTap: (){
                          _sendingMails();
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          'Share',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        leading: const Icon(
                          Icons.share_outlined,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                        onTap: (){
                          _onShareData();
                        }
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          'Rate Us',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        leading: const Icon(
                          Icons.star_rate,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                        onTap: (){
                          _launchURLForRateUs();
                        },
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          'Logout',
                          style: Styles.black18.copyWith(fontSize: 14),
                        ),
                        leading: const Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Repository().logout();
                        },
                      ),
                    ],
                  ),
          ),
    ));


void _sendingMails() async {
  const url = 'mailto:alonecall@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchURLForRateUs() async {
  const url = 'https://play.google.com/store/apps/details?id=bubbleshooter.orig';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _onShareData() async {

  {
    await Share.share('flutter.com'
        );
  }
}
