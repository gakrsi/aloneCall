import 'package:flutter/material.dart';
import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/routes/app_pages.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// Main entry of the application
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

/// A class to create the initial structure of the
/// application and adds routes in the application
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 745),
    builder:()=> GetMaterialApp(
          title: 'Blue Print',
          theme: Styles.lightTheme,
          darkTheme: Styles.darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages,
          initialRoute: AppPages.initial,
        ),
  );
}
