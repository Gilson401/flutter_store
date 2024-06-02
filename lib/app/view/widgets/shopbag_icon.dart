import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/auth_controller.dart';
import 'package:flutter_store/app/controller/products_controller.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:get/get.dart';

class ShopbagIcon extends StatelessWidget {
  const ShopbagIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final authController = Get.put(AuthController());
    return Obx(() => Badge.count(
          count: productController.shopBagProductsId().length,
          isLabelVisible: productController.shopBagProductsId().isNotEmpty &&
              authController.user.value != null,
          child: IconButton(
            tooltip: 'Carrinho',
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () async {
              Future(() => Get.toNamed(Routes.cart));
            },
          ),
        ).paddingOnly(right: 5));
  }
}
