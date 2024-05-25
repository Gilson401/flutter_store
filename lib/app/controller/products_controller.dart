import 'dart:async';

import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/app/model/service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _service = inject<Service>();

  final RxList<Product> productList = <Product>[].obs;

  Rx<Product?> product = Rx<Product?>(null);

  RxBool loading = false.obs;
  Future<void> setLoading(bool bvalue) async {
    loading.value = bvalue;
    update();
  }

  bool isLoading() {
    return loading.value;
  }

  RxString error = 'Sem erro'.obs;
  Future<void> setError(String err) async {
    error.value = err;
    update();
  }

  @override
  void onInit() {
    loadProducts();
    super.onInit();
  }

  setProducts(List<Product> items) => productList.addAll(items);
  setProduct(Product prod) => product.value = prod;

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
