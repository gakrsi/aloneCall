import 'package:alonecall/app/global_widgets/circular_photo.dart';
import 'package:alonecall/app/modules/home/controller/home_controller.dart';
import 'package:alonecall/app/routes/routes_management.dart';
import 'package:alonecall/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget drawer()=>GetBuilder<HomeController>(builder: (_controller)=>Drawer(
  child: Column(
    children: [
      UserAccountsDrawerHeader(
        decoration: const BoxDecoration(color: Colors.black),
          accountName: Text('${_controller.model.name}, ${DateTime.now().year - int.parse(_controller.model.dob.substring(0, 4))}',style: Styles.boldWhite18,),
          accountEmail: Text('${_controller.model.city}, ${_controller.model.country}',style: Styles.white16),
          currentAccountPicture: InkWell(
            onTap: ()=>RoutesManagement.goToOProfileEdit(_controller.model),
            child: CircleAvatar(
            child: circularPhoto(imageUrl: _controller.model.profileImageUrl[0] as String),
        ),
          ),
        otherAccountsPictures: [
          IconButton(icon: const Icon(Icons.edit,color: Colors.white,),onPressed: ()=>RoutesManagement.goToOProfileEdit(_controller.model),)
        ],
      ),
      ListTile(
        title: Text('Audio Sec',style: Styles.black18.copyWith(fontSize: 14),),
        trailing: Text('${_controller.model.audioCoin}   '),
        leading: const Icon(Icons.phone,color: Colors.black,),
      ),
      const Divider(),
      ListTile(
        title: Text('Video Sec',style: Styles.black18.copyWith(fontSize: 14),),
        trailing: Text('${_controller.model.coin}   '),
        leading: const Icon(Icons.videocam,color: Colors.black,),
      ),
      const Divider(),
      ListTile(
        title: Text('Blocked User',style: Styles.black18.copyWith(fontSize: 14),),
        leading: const Icon(Icons.person,color: Colors.black,),
        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
        onTap: RoutesManagement.goToBlockedListScreen,
      ),
      const Divider(),
      ListTile(
        title: Text('Rate Us',style: Styles.black18.copyWith(fontSize: 14),),
        leading: const Icon(Icons.star_rate,color: Colors.black,),
        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
      ),
      const Divider(),
      ListTile(
        title: Text('About Us',style: Styles.black18.copyWith(fontSize: 14),),
        leading: const Icon(Icons.details,color: Colors.black,),
        trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
      ),

    ],
  ),
));