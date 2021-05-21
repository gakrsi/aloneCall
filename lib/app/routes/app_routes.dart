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
  static const call = _Paths.call;
  static const videoCall = _Paths.videoCall;
  static const detailsPage = _Paths.detailsPage;
}

abstract class _Paths{
  static const home = '/home';
  static const login = '/login';
  static const otp = '/otp';
  static const phoneNumber = '/phone_number';
  static const profile = '/profile';
  static const othersProfileDetail = '/othersProfileDetail';
  static const call = '/call';
  static const videoCall = '/video_call';
  static const detailsPage = '/details_page';
}