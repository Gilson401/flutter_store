import 'dart:async';
import 'dart:convert';

import 'package:flutter_store/app/model/local_storage.dart';
import 'package:flutter_store/app/model/local_storage_keys.dart';
import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/app/model/service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _service = inject<Service>();
  final _localDataSource = inject<LocalStorage>();

  final RxList<Product> productList = <Product>[].obs;
  final RxList<int> _favoritedProductsId = <int>[].obs;
  final RxList<int> _shopBagProductsId = <int>[].obs;

  List<int> favoritedProductsId() => _favoritedProductsId.toList();
  List<int> shopBagProductsId() => _shopBagProductsId.toList();

  Rx<Product?> product = Rx<Product?>(null);

  RxBool loading = false.obs;
  Future<void> setLoading(bool bvalue) async {
    loading.value = bvalue;
    update();
  }

  bool isLoading() {
    return loading.value;
  }

  RxString error = 'Not Errors'.obs;
  Future<void> setError(String err) async {
    error.value = err;
    update();
  }

  @override
  void onInit() {
    loadProducts();
    _loadFavorited();
    _loadShopBag();
    super.onInit();
  }

  setProducts(List<Product> items) => productList.addAll(items);
  setProduct(Product prod) => product.value = prod;

  void _loadFavorited() async {
    dynamic dynamicList =
        await _localDataSource.get(LocalStorageKeys.favoritedProducts);

    if (dynamicList == null) {
      return;
    }

    List<int> intList = List<int>.from(jsonDecode(dynamicList));

    if (dynamicList.isNotEmpty) {
      _favoritedProductsId.addAll(intList);
      update();
    }
  }

  Future<void> updateFavorite(int id) async {
    if (_favoritedProductsId.contains(id)) {
      await _removeFavorited(id);
    } else {
      await _addFavorited(id);
    }
  }

  Future<void> _addFavorited(int id) async {
    _favoritedProductsId.add(id);
    update();
    await _localDataSource.set(
        LocalStorageKeys.favoritedProducts, _favoritedProductsId);
  }

  Future<void> _removeFavorited(int id) async {
    _favoritedProductsId.removeWhere((element) => element == id);
    update();
    await _localDataSource.set(
        LocalStorageKeys.favoritedProducts, _favoritedProductsId);
  }

  void _loadShopBag() async {
    dynamic dynamicList =
        await _localDataSource.get(LocalStorageKeys.shopBagProductsId);

    if (dynamicList == null) {
      return;
    }

    List<int> intList = List<int>.from(jsonDecode(dynamicList));

    if (dynamicList.isNotEmpty) {
      _shopBagProductsId.addAll(intList);
      update();
    }
  }

  Future<void> updateShopBag(int id) async {
    if (_shopBagProductsId.contains(id)) {
      await _removeFromShopBag(id);
    } else {
      await _addToShopBag(id);
    }
  }

  Future<void> _addToShopBag(int id) async {
    _shopBagProductsId.add(id);
    update();
    await _localDataSource.set(
        LocalStorageKeys.shopBagProductsId, _shopBagProductsId);
  }

  Future<void> _removeFromShopBag(int id) async {
    _shopBagProductsId.removeWhere((element) => element == id);
    update();
    await _localDataSource.set(
        LocalStorageKeys.shopBagProductsId, _shopBagProductsId);
  }

  Future<void> loadProducts() async {
    try {
      setLoading(true);
      final response = await _service.loadProducts();

      if (response.statusCode < 300) {
        setProducts(response.data);
      } else {
        setError('Erro ao carregar os campeonatos.');
      }
    } catch (error) {
      setError('Erro ao carregar os campeonatos.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadProductById(int id) async {
    try {
      setLoading(true);
      final response = await _service.loadProductById(id);

      if (response.statusCode < 300) {
        setProduct(response.data);
      } else {
        setError('Erro ao carregar os campeonatos.');
      }
    } catch (error) {
      setError('Erro ao carregar os campeonatos.');
    } finally {
      setLoading(false);
    }
  }
}
