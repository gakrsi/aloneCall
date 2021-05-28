import 'package:alonecall/app/theme/dimens.dart';
import 'package:flutter/material.dart';


class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: const Icon(Icons.arrow_back, ),
      centerTitle: true,
      title: const Text('Settings', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            settingsItems('Blocked List'),
            const SizedBox(height: 12,),
            settingsItems('Rate US'),
            const SizedBox(height: 12,),
            settingsItems('About Us'),
          ],
        ),
      ),
    ),
  );
}

Widget settingsItems(String Title)
=> Container(
  height: 50,
  width: Dimens.screenWidth - 40,
  decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20)
  ),
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        const SizedBox(width: 6,),
        Text(Title, style: TextStyle(fontWeight: FontWeight.w600),),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  ),
);
