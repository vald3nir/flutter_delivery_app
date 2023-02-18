import 'dart:developer';

import 'package:dio/dio.dart';

import './auth_repository.dart';
import '../../core/config/rest_client/custom_dio.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/exceptions/unauthorized_exception.dart';
import '../../model/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log("Permissão negada", error: e, stackTrace: s);
        throw UnauthorizedException();
      }
      log("Erro ao logar", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao logar");
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e, s) {
      log("Erro ao registrar o usuário", error: e, stackTrace: s);
      throw RepositoryException(message: "Erro ao registrar o usuário");
    }
  }
}
