import 'package:flutter/material.dart';
import 'package:flutter_blueprint/app/data/service/common_service.dart';
import 'package:flutter_blueprint/app/routes/app_pages.dart';
import 'package:flutter_blueprint/app/theme/styles.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

/// Initialize the services before the app starts.
Future<void> initServices() async {
  Get.put(
    CommonService(),
    permanent: true,
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Blue Print',
        theme: Styles.lightTheme,
        debugShowCheckedModeBanner: false,
        getPages: AppPages.pages,
      );
}
