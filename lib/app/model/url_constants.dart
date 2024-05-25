import 'package:flutter/foundation.dart';

  const String urlBase = 'https://fakestoreapi.com/';
class UrlConstants {
  static const bool releaseMode = kReleaseMode;
  static const String baseUrl = urlBase;
  static const String products = '$urlBase/products';
  static String productById (int id) => 'products/$id';
}
