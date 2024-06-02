import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/products_controller.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:flutter_store/app/view/product_page.dart';
import 'package:flutter_store/app/view/widgets/bottom_bar.dart';
import 'package:flutter_store/app/view/widgets/shopbag_icon.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final String? cart;
  const CartPage({super.key, this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final productController = Get.put(ProductController());

  List<Product> displayList() {
    return productController.productList
        .where((p0) => productController.shopBagProductsId().contains(p0.id))
        .toList();
  }

  double totalPrice(List<Product> list) {
    double sum = displayList()
        .fold(0.0, (double sum, Product next) => sum + next.price!);
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Bag'),
        centerTitle: true,
        actions: const [ShopbagIcon()],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Obx(() {
            return Text(NumberFormat.currency(
                    locale: 'pt_BR', 
                    symbol: 'R\$', 
                    decimalDigits: 2)
                .format(totalPrice(productController.productList)));
          }),
          Obx(() {
            if (productController.isLoading()) {
              return const Expanded(
                child:  Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(192, 88, 55, 10),
                  ),
                ),
              );
            }

            List<Product> entries = [...displayList()];

            if (entries.isEmpty) {
              return const Expanded(
                child: Center(
                  child: Text('No items in bag'),
                ),
              );
            }

            return Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          productController.updateShopBag(entries[index].id!);
                        },
                      ),
                      title:
                          Text('Product ${entries[index].title}'.toUpperCase()),
                      subtitle: Text('Product ${entries[index].category}'),
                      leading: Image.network(
                        entries[index].image!,
                        width: 100,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Icon(Icons.image_not_supported_rounded);
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<Widget>(
                            builder: (_) =>
                                ProductPage(product: entries[index]),
                            settings: RouteSettings(
                                name: Routes.product,
                                arguments:
                                    ProductPage(product: entries[index]))));
                      },
                    );
                  }),
            );
          }),
        ],
      )),
      bottomNavigationBar: const BottomBar(isElevated: false, isVisible: true),
    );
  }
}
