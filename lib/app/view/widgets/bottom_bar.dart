import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/auth_controller.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:flutter_store/app/controller/products_controller.dart';

import 'package:get/get.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.isElevated,
    required this.isVisible,
  });

  final bool isElevated;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final authController = Get.put(AuthController());

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? 80.0 : 0,
      child: BottomAppBar(
        elevation: isElevated ? null : 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              tooltip: 'Minha conta',
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Future(() => Get.toNamed(Routes.account));
              },
            ),
            IconButton(
              tooltip: 'Ir para Home',
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.home);
              },
            ),
            Obx(() => Badge.count(
                  count: productController.favoritedProductsId().length,
                  isLabelVisible:
                      productController.favoritedProductsId().isNotEmpty &&
                          authController.user.value != null,
                  child: IconButton(
                    tooltip: 'Ir para meus Favoritos',
                    icon: const Icon(Icons.favorite),
                    onPressed: () async {
                      Future(() => Get.toNamed(Routes.favorites));
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
