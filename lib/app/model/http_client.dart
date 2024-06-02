import 'package:flutter_store/app/model/inject.dart';
import 'package:flutter_store/app/model/user_manager.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

import 'url_constants.dart';

enum UserTokenType { headerToken, authToken, noAuthBearer, noAuthBasic }

abstract class HttpClient {
  Future<Response<T>> get<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  });

  Future<Response<T>> post<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  });

  Future<Response<T>> put<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  });

  Future<Response<T>> patch<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  });

  Future<Response<T>> delete<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  });
}

class DioImpl implements HttpClient {
  final Dio _client; 
  DioImpl() : _client = Dio() {
    _client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler? handler,
        ) async {
          final String baseUrl = options.extra['baseUrl'] as String;
          final bool useToken = options.extra['useToken'] as bool;

          options.baseUrl = baseUrl;

          options.contentType ??= 'application/json';

          if (useToken) {
            final String? tokenToUse;
            final UserTokenType tokenType =
                options.extra['tokenType'] as UserTokenType;
            if (tokenType == UserTokenType.noAuthBasic) {
              tokenToUse = '=';
            } else if (tokenType == UserTokenType.noAuthBearer) {
              tokenToUse = '';
            } else {
              final userManager = inject<UserManager>();
              tokenToUse = userManager.token;
            }

            if (tokenType == UserTokenType.noAuthBasic) {
              options.headers['Authorization'] = 'Basic $tokenToUse';
            } else {
              options.headers['Authorization'] = 'Bearer $tokenToUse';
            }
          }

          handler?.next(options);
        },
        onResponse: (
          Response<dynamic> response,
          ResponseInterceptorHandler? handler,
        ) {
          final String logInfo = <String>[
            '[DioImpl.onResponse]> [${response.statusCode}] ${response.requestOptions.uri}',
            if (response.statusMessage != null &&
                response.statusMessage!.isNotEmpty)
              '\tstatusMessage: ${response.statusMessage}',
          ].join('\n');

          _logInfo(logInfo);

          handler?.next(response);
        },
        onError: (
          DioError error,
          ErrorInterceptorHandler? handler,
        ) {
          final String logInfo = <String>[
            '[DioImpl.onError]> [${error.response?.statusCode ?? '---'}] ${error.requestOptions.uri}',
            '\terror: [${error.type}] ${error.message}',
            '\tstatus message: ${error.response?.statusMessage}',
            '\tRequest data: ${error.requestOptions.data}',
            '\tResponse data: ${error.response?.data}',
          ].join('\n');

          _logInfo(logInfo);

          handler?.next(error);
        },
      ),
    );
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  }) async {
    return _client.get<T>(
      path,
      queryParameters: queryParameters,
      options: (options ?? Options()).copyWith(
        extra: <String, dynamic>{
          'baseUrl': baseUrl,
          'useToken': useToken,
          'tokenType': tokenType,
        },
      ),
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  }) =>
      _client.post<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: <String, dynamic>{
            'baseUrl': baseUrl,
            'useToken': useToken,
            'tokenType': tokenType,
          },
        ),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  @override
  Future<Response<T>> put<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  }) =>
      _client.put<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: <String, dynamic>{
            'baseUrl': baseUrl,
            'useToken': useToken,
            'tokenType': tokenType,
          },
        ),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  @override
  Future<Response<T>> patch<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  }) =>
      _client.patch<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: <String, dynamic>{
            'baseUrl': baseUrl,
            'useToken': useToken,
            'tokenType': tokenType,
          },
        ),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  @override
  Future<Response<T>> delete<T>(
    String path, {
    String baseUrl = UrlConstants.baseUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useToken = true,
    UserTokenType tokenType = UserTokenType.authToken,
  }) =>
      _client.delete<T>(
        path,
        data: body,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          extra: <String, dynamic>{
            'baseUrl': baseUrl,
            'useToken': useToken,
            'tokenType': tokenType,
          },
        ),
      );

  void _logInfo(String text) {
    if (kDebugMode) {
      debugPrint(text);
    }
  }
}
