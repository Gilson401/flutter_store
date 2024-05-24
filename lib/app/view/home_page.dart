import 'package:flutter/material.dart';
import 'package:flutter_store/app/view/category_page.dart';
import 'package:get/get.dart';
import 'package:flutter_store/app/controller/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomeController());

  HomePage({super.key});

  final List<String> entries = <String>[
  "electronics",
  "jewelery",
  "men's clothing",
  "women's clothing"
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: SafeArea(
        child: ListView.separated(
            padding: const EdgeInsets.all(8),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Category ${entries[index]}'.toUpperCase()),
                subtitle: Text('Category ${entries[index]}'),
                leading: Image.network('https://picsum.photos/200'),
                trailing: const SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.arrow_right_alt_outlined)),
                onTap: () {
                  Get.to(CategoryPage(category:  entries[index]));
                },
              );
            }),
      ),
    );
  }
}
