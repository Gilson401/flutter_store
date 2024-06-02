import 'package:flutter_store/app/view/account_page.dart';
import 'package:flutter_store/app/view/cart_page.dart';
import 'package:flutter_store/app/view/favorites_page.dart';
import 'package:flutter_store/app/view/product_page.dart';
import 'package:flutter_store/app/view/unknown_page.dart';
import 'package:get/get.dart';
import 'package:flutter_store/app/view/home_page.dart';
import 'package:flutter_store/app/view/login_page.dart';
import 'app_routes.dart';
import 'package:flutter_store/routes/middlewares/auth_guard.dart';

class AppPages {
  static const initial = Routes.login;

  static GetPage unknown = GetPage(
    name: Routes.unknown,
    page: () => const UnknownPage(),
  );

  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      middlewares: [
        SendLoggedToHome(),
      ]
    ),
    GetPage(
        name: Routes.product,
        page: () => const ProductPage(),
        middlewares: [
          OnlyLoggedAllowed(),
        ]),

    GetPage(
        name: Routes.account,
        page: () => const AccountPage(),
        middlewares: [
          OnlyLoggedAllowed(),
        ]),
        
    GetPage(
        name: "${Routes.product}/:id",
        page: () => const ProductPage(),
        middlewares: [
          OnlyLoggedAllowed(),
        ]),
    GetPage(
      name: Routes.cart,
      page: () => const CartPage(),
      middlewares: [
          OnlyLoggedAllowed(),
        ]
    ),
    GetPage(
      name: Routes.favorites,
      page: () => const FavoritesPage(),
      middlewares: [
          OnlyLoggedAllowed(),
        ]
    ),
    unknown
  ];
}
