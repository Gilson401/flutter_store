import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final String? cart;
  const CartPage({super.key, this.cart });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text(' My Cart')),
      body: Center(child: Text('Cart ${widget.cart ?? 'UnsetProduct'}')),
    ));
  }
}
