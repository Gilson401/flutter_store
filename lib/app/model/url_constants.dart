import 'package:flutter/foundation.dart';

  const String urlBase = 'https://fakestoreapi.com/';
class UrlConstants {
  static const bool releaseMode = kReleaseMode;
  static const String baseUrl = urlBase;
  static const String products = '$urlBase/products';
  static const String categories = '$urlBase/products/categories';
  static const String login = '${urlBase}auth/login';

  static String productById (int id) => 'products/$id';
  static String userById (int id) => 'users/$id';
}
