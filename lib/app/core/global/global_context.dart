import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalContext {
  static GlobalContext? _instance;

  //! The Navigator key will always be private
  late final GlobalKey<NavigatorState> _navigatorKey;

  GlobalContext._();

  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  Future<void> loginExpire() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();

    // showTopSnackBar(
    //   _navigatorKey.currentState!.overlay!,
    //   const CustomSnackBar.error(
    //     message: "Sessão expirada",
    //     backgroundColor: Colors.black,
    //   ),
    // );

    _navigatorKey.currentState!.popUntil(ModalRoute.withName("/home"));
  }
}
