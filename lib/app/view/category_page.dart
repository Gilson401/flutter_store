import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {



  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(' ${widget.category}')),
      body: Center(child: Text('Categorie ${widget.category}')),
    ));
  }
}
