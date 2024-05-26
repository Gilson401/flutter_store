import 'package:flutter_store/app/view/cart_page.dart';
import 'package:flutter_store/app/view/product_page.dart';
import 'package:flutter_store/app/view/unknown_page.dart';
import 'package:get/get.dart';
import 'package:flutter_store/app/view/home_page.dart';
import 'package:flutter_store/app/view/login_page.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.login;

  static GetPage unknown = GetPage(
    name: Routes.unknown,
    page: () => const UnknownPage(),
  );

  static final routes = [
    GetPage(
      name: Routes
          .home, //apenas uma string para ser o nome da rota. Separamos em outro módulo
      page: () => const HomePage(), //Widget da página
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: Routes.product,
      page: () => const ProductPage(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => const CartPage(),
    ),
    unknown
  ];
}
