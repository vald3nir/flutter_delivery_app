// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:delivery_app/app/core/exceptions/expire_token_exception.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:delivery_app/app/core/config/rest_client/custom_dio.dart';
import 'package:delivery_app/app/core/global/global_context.dart';

class AuthInterceptor extends Interceptor {
  final CustomDio _dio;

  AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString("accessToken");
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        if (err.requestOptions.path != "/auth/refresh") {
          await _refrashToken(err);
          await _refrashRequest(err, handler);
        } else {
          GlobalContext.instance.loginExpire();
        }
      } catch (e) {
        GlobalContext.instance.loginExpire();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refrashToken(DioError err) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final refreshToken = sp.getString("refreshToken");

      if (refreshToken == null) {
        return;
      }

      final resultRefresh = await _dio.auth().put(
        "/auth/refresh",
        data: {
          'refresh_token': refreshToken,
        },
      );
      sp.setString("accessToken", resultRefresh.data['accessToken']);
      sp.setString("refreshToken", resultRefresh.data['refreshToken']);
    } on DioError catch (e, s) {
      log("Token expirado", error: e, stackTrace: s);
      throw ExpireTokenException();
    }
  }

  Future<void> _refrashRequest(
      DioError err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;
    final result = await _dio.request(
      requestOptions.path,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method,
      ),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(Response(
      requestOptions: requestOptions,
      data: result.data,
      statusCode: result.statusCode,
      statusMessage: result.statusMessage,
    ));
  }
}
