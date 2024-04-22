part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const DASHBOARD = _Paths.DASHBOARD;
  static const POSTING = _Paths.POSTING;
  static const USER = _Paths.USER;
  static const LIKED = _Paths.LIKED;
}

abstract class _Paths {
  _Paths._();

  static const DASHBOARD = '/dashboard';
  static const POSTING = '/posting';
  static const USER = '/user';
  static const LIKED = '/liked';
}
