import 'package:flutter/foundation.dart';
import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/url_constants.dart';
import 'package:flutter_store/app/model/user_manager.dart';
import 'response.dart';
import 'http_client.dart';
import 'package:dio/dio.dart';

class AuthService {
  final _client = inject<HttpClient>();

  Future<HttpResponse> login(String userName, String password) async {
    final HttpResponse<UserManager?> response = HttpResponse<UserManager?>();

    final body = {'username': userName, 'password': password};

    Options options = Options(
        contentType: 'x-www-form-urlencoded',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'});

    try {
      //O login retorna apenas um token com username e iat
      final Response<dynamic> res = await _client.post(
        UrlConstants.login,
        baseUrl: UrlConstants.baseUrl,
        body: body,
        options: options,
        useToken: false,
      );

//Como login não retorna dados do user optei por mapear para pegar os ids
      List<String> users = [
        '',
        'johnd',
        'mor_2314',
        'kevinryan',
        'donero',
        'derek',
        'david_r',
        'snyder',
        'hopkins',
        'kate_h',
        'jimmie_k'
      ];

      int index = users.indexOf(userName);
      final Response<dynamic> userInformation = await _client.get(
        UrlConstants.userById(index),
        baseUrl: UrlConstants.baseUrl,
        options: options,
        useToken: false,
      );

      UserManager loggedUser;
      loggedUser = UserManager.fromJson(
          {...userInformation.data, 'token': res.data['token']});

      response
        ..isSuccess = true
        ..statusCode = HttpStatus.success
        ..data = loggedUser;

      return response;
    } catch (error) {
      debugPrint('Erro login. ${error.toString()}');
      int? statusCode;
      if (error is DioError) {
        statusCode = error.response?.statusCode;
      }
      final String msg = error.toString();

      response
        ..isSuccess = false
        ..statusCode = statusCode ?? HttpStatus.serverError
        ..message = msg;
    }

    return response;
  }
}
