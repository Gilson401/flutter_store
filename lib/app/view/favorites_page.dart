import 'package:flutter/material.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/app/view/widgets/animated_card.dart';
import 'package:flutter_store/app/view/widgets/bottom_bar.dart';
import 'package:flutter_store/app/view/widgets/loading_indicator.dart';
import 'package:flutter_store/app/view/widgets/shopbag_icon.dart';
import 'package:flutter_store/app/controller/products_controller.dart';
import 'package:get/get.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('My favorites'),
        actions: const [ShopbagIcon()],
      ),
      body: Obx(() {
        if (productController.isLoading()) {
          return const LoadingIndicator(isLoading: true);
        }

        if (productController.favoritedProductsId().isEmpty) {
          return const Center(child: Text('Nenhum item favoritado.'));
        }

        return SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
          return Center(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                for (int i in productController.favoritedProductsId())
                  SizedBox(
                    width: 300,
                    child: Builder(builder: (context) {
                      Product product = productController.productList
                          .firstWhere((p0) => p0.id == i);
                      return FavoritedItemCard(
                          product: product,
                          onClickAddShopBag: () =>
                              productController.updateShopBag(product.id!),
                          onClickRemoveFavorite: () =>
                              productController.updateFavorite(product.id!));
                    }),
                  )
              ],
            ),
          );
        }));
      }),
      bottomNavigationBar: const BottomBar(isElevated: false, isVisible: true),
    ));
  }
}
