import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/app/model/service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final _service = inject<Service>();

  final RxList<Product> productList = <Product>[].obs;

  final RxBool _loading = false.obs;
  void setLoading(bool value) => _loading.value = value;
  bool isLoading () => _loading.value;

  final RxString _error = 'Sem erro'.obs;
  void setError(String value) => _error.value = value;
  String  error () => _error.value;

  setProducts(List<Product> items) {
    productList.addAll(items);
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
}
