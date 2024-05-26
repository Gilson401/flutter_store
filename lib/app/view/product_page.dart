import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/products_controller.dart';

import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_store/app/view/widgets/bottom_bar.dart';
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
  Product? product;
  bool isFavorited = false;

  @override
  void initState() {
    super.initState();
    productController.product.listen((p0) => setState(() => product = p0));

    productController.error.listen((event) {
      Future(() => Get.toNamed(Routes.HOME));
    });

    if (widget.product == null) {
      String uriBaseString = Uri.base.toString().replaceFirst('/#/', '/');
      dynamic pardesUri = Uri.parse(uriBaseString);
      String? id = pardesUri.queryParameters['id'];
      if (id != null) {
        productId = pardesUri.queryParameters['id'];

        productController.loadProductById(int.parse(productId));
      } else {
        Future.delayed(
            const Duration(seconds: 1), () => Get.toNamed(Routes.HOME));
      }
    } else {
      product = widget.product;
      starRatingValue = widget.product!.rating!.rate!;
      starRatingCount = widget.product!.rating!.count!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
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
          icon: Icon(
            Icons.favorite,
            color: productController.favoritedProductsId().contains(id)
                ? Colors.red
                : null,
          ),
          onPressed: () async {
            await productController.updateFavorite(id);

            setState(() => isFavorited = !isFavorited);

            final SnackBar snackBar = SnackBar(
              content: const Text('Item favoritado'),
              action: SnackBarAction(
                label: 'Ok',
                onPressed: () {},
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        );
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Código ${product?.id}'),
        actions: [
          IconButton(
            tooltip: 'Carrinho',
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(
              product!.image!,
              width: 100,
            ),
            Center(
                child:
                    Text('Product ${product?.description ?? 'UnsetProduct'}')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product!.price!.toString()),
                starRating(),
                Text(product!.category!),
                iconButton(product!.id!),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  print('Adicionar a sacola');
                },
                child: const Text('Adicionar à Sacola'))
          ],
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
