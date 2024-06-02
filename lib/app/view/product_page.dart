import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/products_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_store/app/view/widgets/bottom_bar.dart';
import 'package:flutter_store/app/view/widgets/shopbag_icon.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:get/get.dart';
import 'dart:core';

class ProductPage extends StatefulWidget {
  final Product? product;
  const ProductPage({super.key, this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productController = Get.put(ProductController());

  double starRatingValue = 0;
  int starRatingCount = 0;
  String productId = '';
  Product? internalProduct;

  void resolveProduct() async {
    if (widget.product != null) {
      setState((){

      internalProduct = widget.product;
      starRatingValue = widget.product!.rating!.rate!;
      starRatingCount = widget.product!.rating!.count!;
      });
      return;
    }

    final param = ModalRoute.of(context)?.settings.arguments;

    final p = param == null ? null : param as Map<String, dynamic>;
    if (p != null && p['product'] != null) {
      setState(() => internalProduct = p['product']);
      return;
    }

    String uriBaseString = Uri.base.toString().replaceFirst('/#/', '/');
    Uri pardesUri = Uri.parse(uriBaseString);
    int? id = int.tryParse(pardesUri.path.split('/').last);
    if (id != null) {
      await productController.loadProductById(id);
      return;
    }
    await Get.defaultDialog(
            title: 'Não foi possível carregar.',
            middleText: 'Redirecionando para Home')
        .then((value) {
      Future.delayed(
          const Duration(seconds: 1), () => Get.toNamed(Routes.home));
    });
  }

  @override
  void initState() {
    super.initState();
    productController.product.listen((p0) => setState(() => internalProduct = p0));

    productController.error.listen((event) {
      Duration? duration = const Duration(seconds: 3);
      Get.snackbar('Não foi possível carregar.', 'Redirecionando para Home',
          duration: duration);
      Future.delayed(duration, () => Get.toNamed(Routes.home));
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      resolveProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (internalProduct == null) {
      return Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Text('Carregando produto: $productId')
        ],
      )));
    }

    IconButton iconButton(int id) => IconButton(
          tooltip: 'Favorite',
          icon: Obx(() {
            return Icon(
              Icons.favorite,
              color: productController.favoritedProductsId().contains(id)
                  ? Colors.red
                  : null,
            );
          }),
          onPressed: () async {
            await productController.updateFavorite(id);
          },
        );
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Código ${internalProduct?.id}'),
        actions: const [ShopbagIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                internalProduct!.image!,
                width: 100,
              ),
              Center(
                  child: Text(
                'Product ${internalProduct?.description ?? 'UnsetProduct'}',
              )).paddingOnly(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text(internalProduct!.title!.toString())),
                  Expanded(flex: 2, child: starRating()),
                ],
              ).paddingOnly(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(NumberFormat.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$', 
                          decimalDigits: 2)
                      .format(internalProduct!.price!)),
                ],
              ).paddingOnly(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconButton(internalProduct!.id!),
                  Expanded(
                    child: Obx(() {
                      return ElevatedButton(
                          onPressed: productController
                                  .shopBagProductsId()
                                  .contains(internalProduct!.id!)
                              ? null
                              : () async {
                                  if (internalProduct?.id != null) {
                                    await productController
                                        .updateShopBag(internalProduct!.id!);
                                  }
                                },
                          child: const Text('Adicionar à Sacola'));
                    }),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBar(isElevated: false, isVisible: true),
    ));
  }

  RatingStars starRating() {
    return RatingStars(
      value: starRatingValue,
      onValueChanged: (v) {
        setState(() {
          starRatingValue = v;
        });
      },
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      starCount: 5,
      starSize: 20,
      valueLabelColor: const Color(0xff9b9b9b),
      valueLabelTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 12.0),
      valueLabelRadius: 10,
      maxValue: 5,
      starSpacing: 2,
      maxValueVisibility: true,
      valueLabelVisibility: true,
      animationDuration: const Duration(milliseconds: 1000),
      valueLabelPadding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      valueLabelMargin: const EdgeInsets.only(right: 8),
      starOffColor: const Color(0xffe7e8ea),
      starColor: Colors.yellow,
    );
  }
}
