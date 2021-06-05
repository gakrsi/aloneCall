import 'package:alonecall/app/theme/theme.dart';
import 'package:alonecall/app/utils/string_constant.dart';
import 'package:flutter/material.dart';

class FemaleProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.wallet,
          style: Styles.boldWhite20,
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Balance',style: Styles.black18,),
              trailing: Text('30',style: Styles.blackBold18,),
            ),
            const Divider()
          ],
        ),
      ),
      ),
  );
}
