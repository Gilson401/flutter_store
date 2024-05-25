import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/product_model.dart';
import 'package:flutter_store/app/model/url_constants.dart';
import 'response.dart';
import 'http_client.dart';
import 'package:dio/dio.dart';

class Service {
  final _client = inject<HttpClient>();

  Future<HttpResponse> loadProducts() async {
    final HttpResponse<List<Product>?> response = HttpResponse<List<Product>>();

    try {
      final Response<dynamic> res = await _client.get('products',
          baseUrl: UrlConstants.baseUrl,
          useToken: true,
          tokenType: UserTokenType.noAuthBearer);

      List<Product> data = [];

      final List<dynamic> products = res.data as List;

      if (products.isNotEmpty) {
        data = products.map((e) => Product.fromJson(e)).toList();
      }

      response
        ..isSuccess = true
        ..statusCode = HttpStatus.success
        ..data = data;

      return response;
    } catch (error) {
      int? statusCode;
      if (error is DioError) {
        statusCode = error.response?.statusCode;
      }
      const String msg = 'err_msg_config_auth';

      response
        ..isSuccess = false
        ..statusCode = statusCode ?? HttpStatus.serverError
        ..message = msg;
    }

    return response;
  }

  Future<HttpResponse> loadProductById(int id) async {
    final HttpResponse<Product?> response = HttpResponse<Product?>();

    try {
      final Response<dynamic> res = await _client.get(
          UrlConstants.productById(id),
          baseUrl: UrlConstants.baseUrl,
          useToken: true,
          tokenType: UserTokenType.noAuthBearer);

      Product data;
      data = Product.fromJson(res.data);

      response
        ..isSuccess = true
        ..statusCode = HttpStatus.success
        ..data = data;

      return response;
    } catch (error) {
      int? statusCode;
      if (error is DioError) {
        statusCode = error.response?.statusCode;
      }
      const String msg = 'err_msg_config_auth';

      response
        ..isSuccess = false
        ..statusCode = statusCode ?? HttpStatus.serverError
        ..message = msg;
    }

    return response;
  }
}
