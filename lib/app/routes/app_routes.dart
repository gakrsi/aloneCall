part of 'app_pages.dart';


/// A chunks of routes and the path names which will be used to create
/// routes in [AppPages].
abstract class AppRoutes{
  static const home = _Paths.home;
  static const login = _Paths.login;
  static const otp = _Paths.otp;
  static const phoneNumber = _Paths.phoneNumber;
  static const profile = _Paths.profile;
  static const othersProfileDetail = _Paths.othersProfileDetail;
}

abstract class _Paths{
  static const home = '/home';
  static const login = '/login';
  static const otp = '/otp';
  static const phoneNumber = '/phone_number';
  static const profile = '/profile';
  static const othersProfileDetail = '/othersProfileDetail';
}