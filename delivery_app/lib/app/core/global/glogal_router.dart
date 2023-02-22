import 'package:delivery_app/app/pages/auth/login/login_router.dart';
import 'package:delivery_app/app/pages/auth/register/register_router.dart';
import 'package:delivery_app/app/pages/home/home_router.dart';
import 'package:delivery_app/app/pages/order/order_completed_paga.dart';
import 'package:delivery_app/app/pages/order/order_router.dart';
import 'package:delivery_app/app/pages/product_detail/product_detail_router.dart';
import 'package:delivery_app/app/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

class GlogalRouter {
  GlogalRouter._();

  static routers(BuildContext context) {
    return {
      '/': (context) => const SplashPage(),
      '/home': (context) => HomeRouter.page,
      '/productDetail': (context) => ProductDetailRouter.page,
      '/auth/login': (context) => LoginRouter.page,
      '/auth/register': (context) => RegisterRouter.page,
      '/order': (context) => OrderRouter.page,
      '/order/completed': (context) => const OrderCompletedPaga(),
    };
  }

  static navigateToHome(BuildContext context) {
    Navigator.of(context).popAndPushNamed("/home");
  }
}
