import 'package:get/get.dart';

part 'app_routes.dart';

/// Contains the list of pages or routes taken across the whole application.
/// This will prevent us in using context for navigation. And also providing
/// the blocs required in the next named routes.
///
/// [pages] : will contain all the pages in the application as a route
///                 and will be used in the material app.
abstract class AppPages{

  static var transitionDuration = const Duration(
    milliseconds: 300,
  );

  static final pages = <GetPage>[
    // GetPage(
    //   name: _Paths.login,
    //   transitionDuration: transitionDuration,
    //   page: () => LoginView(),
    //   binding: LoginBinding(),
    //   transition: Transition.downToUp,
    // ),
  ];

}