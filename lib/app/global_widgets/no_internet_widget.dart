import 'package:flutter/material.dart';
import 'package:flutter_blueprint/app/theme/theme.dart';

/// A no internet widget which will be shown if network connection is not
/// available.
class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black12,
    body: Padding(
      padding: Dimens.edgeInsets15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Internet',
            textAlign: TextAlign.center,
            style: Styles.boldWhite23,
          ),
        ],
      ),
    ),
  );
}
