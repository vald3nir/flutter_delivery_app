import 'dart:developer';

import 'package:delivery_app/app/core/exceptions/unauthorized_exception.dart';
import 'package:delivery_app/app/pages/auth/login/login_state.dart';
import 'package:delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(
    this._authRepository,
  ) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));

      final authLogin = await _authRepository.login(
        email = email,
        password = password,
      );

      final sp = await SharedPreferences.getInstance();
      sp.setString('accessToken', authLogin.accessToken);
      sp.setString('refreshToken', authLogin.refreshToken);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (e, s) {
      log("Login ou senha inválidos", error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.loginError,
          errorMessage: "Login ou senha inválidos"));
    } catch (e, s) {
      log("Erro ao logar", error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.error, errorMessage: "Erro ao logar"));
    }
  }
}
