import 'package:flutter/material.dart';
import 'package:flutter_store/app/controller/products_controller.dart';
import 'package:flutter_store/app/model/category_model.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/routes/app_routes.dart';
import 'package:flutter_store/util/assets_constants.dart';
import 'package:flutter_store/app/view/product_page.dart';
import 'package:flutter_store/app/view/widgets/bottom_bar.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String categoryFilter = CategoryType.all.name;
  final productController = Get.put(ProductController());

  final List<Category> categories = [
    Category(
        description: CategoryType.all.description,
        icon: AssetsConstants.logo,
        name: CategoryType.all.name),
    Category(
        description: CategoryType.electronics.description,
        icon: AssetsConstants.electronics,
        name: CategoryType.electronics.name),
    Category(
        description: CategoryType.jewelery.description,
        icon: AssetsConstants.jewelery,
        name: CategoryType.jewelery.name),
    Category(
        description: CategoryType.womensClothing.description,
        icon: AssetsConstants.womenClothing,
        name: CategoryType.womensClothing.name),
    Category(
        description: CategoryType.mensClothing.description,
        icon: AssetsConstants.mensClothing,
        name: CategoryType.mensClothing.name),
  ];

  List<Product> displayList() {
    if (categoryFilter == CategoryType.all.name) {
      return productController.productList;
    }
    return productController.productList
        .where((p0) => p0.category == categoryFilter)
        .toList();
  }

  @override
  void initState() {
    super.initState();
  }

    @override
  void dispose() {
    productController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Store Home'),
        centerTitle: true,
        actions: [],
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 100,
            child: categoryListView(),
          ),
          GetX<ProductController>(
              init: productController,
              builder: (_) {
                if (_.isLoading()) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(192, 88, 55, 10),
                    ),
                  );
                }

                return const SizedBox.shrink();
              }),
          Expanded(
            child: Obx(() {
              
              List<Product> entries = [...displayList()];
              return ListView.separated(
                  padding: const EdgeInsets.all(8),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
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
                                name: Routes.PRODUCT,
                                arguments:
                                    ProductPage(product: entries[index]))));
                      },
                    );
                  });
            }),
          ),
        ],
      )),
      bottomNavigationBar: const BottomBar(isElevated: false, isVisible: true),
    );
  }

  ListView categoryListView() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (Category category in categories)
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                setState(() => categoryFilter = category.name);
              },
              child: SizedBox(
                width: 100,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                            fit: BoxFit.scaleDown,
                            width: 50,
                            height: 50,
                            category.icon),
                      ),
                      Expanded(
                          child: Center(
                              child: Text(
                        category.description,
                        textAlign: TextAlign.center,
                      ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
