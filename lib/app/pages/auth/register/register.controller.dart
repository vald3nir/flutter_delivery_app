import 'dart:developer';

import 'package:delivery_app/app/pages/auth/register/register_state.dart';
import 'package:delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterController(
    this._authRepository,
  ) : super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.regiter));
      await _authRepository.register(
        name = name,
        email = email,
        password = password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e, s) {
      log("Erros ao registrar usuário", error: e, stackTrace: s);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
