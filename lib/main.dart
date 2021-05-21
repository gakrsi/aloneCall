import 'package:alonecall/app/data/repository/repository_method.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:alonecall/app/data/service/common_service.dart';
import 'package:alonecall/app/routes/app_pages.dart';
import 'package:alonecall/app/theme/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:alonecall/app/utils/utility.dart';

/// Main entry of the application sb
void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    var uid = await initServices();
    runApp(MyApp(uid: uid,));
  } catch (error) {
    Utility.printELog(error.toString());
  }
}
/// Initialize the services before the app starts.
Future<String> initServices() async {
  await Firebase.initializeApp();
  Get.put(CommonService(), permanent: true,);
  return Repository().currentUser();
}

/// A class to create the initial structure of the
/// application and adds routes in the application
class MyApp extends StatelessWidget {
  MyApp({this.uid});
  final String uid;
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 745),
    builder:()=> GetMaterialApp(
      title: 'AloneCall',
      theme: Styles.lightTheme,
      darkTheme: Styles.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: (uid == null)?AppPages.initial:AppRoutes.home,
    ),
  );
}