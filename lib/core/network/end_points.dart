class EndPoints {
  // constants
  static const int pageSize = 10;
  static const int maxPages = 10;

  // base
  static const String domain = "randomuser.me";
  static const String base = 'https://$domain';
  static const String baseUrl = '$base/api';

  // auth
  static const String refreshToken = '/auth/refresh-token';

  // users
  static const String getUsers = '/';
}
