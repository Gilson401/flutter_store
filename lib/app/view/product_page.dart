import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String? product;
  const ProductPage({super.key, this.product });

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {



  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(' ${widget.product ?? 'UnsetProduct'}')),
      body: Center(child: Text('Product ${widget.product ?? 'UnsetProduct'}')),
    ));
  }
}
