// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RegisterStatusMatch on RegisterStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() regiter,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == RegisterStatus.initial) {
      return initial();
    }

    if (v == RegisterStatus.regiter) {
      return regiter();
    }

    if (v == RegisterStatus.success) {
      return success();
    }

    if (v == RegisterStatus.error) {
      return error();
    }

    throw Exception('RegisterStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? regiter,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == RegisterStatus.initial && initial != null) {
      return initial();
    }

    if (v == RegisterStatus.regiter && regiter != null) {
      return regiter();
    }

    if (v == RegisterStatus.success && success != null) {
      return success();
    }

    if (v == RegisterStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
