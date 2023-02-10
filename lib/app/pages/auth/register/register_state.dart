// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:match/match.dart';

part 'register_state.g.dart';

@match
enum RegisterStatus {
  initial,
  regiter,
  success,
  error,
}

class RegisterState {
  final RegisterStatus status;

  RegisterState({
    required this.status,
  });

  const RegisterState.initial() : status = RegisterStatus.initial;

  RegisterState copyWith({
    RegisterStatus? status,
  }) {
    return RegisterState(
      status: status ?? this.status,
    );
  }
}
