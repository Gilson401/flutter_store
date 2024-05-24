import 'package:flutter_store/app/view/cart_page.dart';
import 'package:flutter_store/app/view/product_page.dart';
import 'package:get/get.dart';
import 'package:flutter_store/app/view/home_page.dart';
import 'package:flutter_store/app/view/login_page.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.HOME, //apenas uma string para ser o nome da rota. Separamos em outro módulo
      page: () => HomePage(), //Widget da página 
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartPage(),
    ),
  ];
}
