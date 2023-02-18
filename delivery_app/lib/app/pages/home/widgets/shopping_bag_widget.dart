// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/app/core/extenions/formatter_extension.dart';
import 'package:delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:delivery_app/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:delivery_app/app/dto/order_product_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();

    if (!sp.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed("/auth/login");
      if (loginResult == null || loginResult == false) return;
    }

    final updateBag = await navigator.pushNamed('/order', arguments: bag);
    controller.updateBag(updateBag as List<OrderProductDto>);
  }

  const ShoppingBagWidget({
    super.key,
    required this.bag,
  });

  @override
  Widget build(BuildContext context) {
    final totalBag = bag
        .fold<double>(
          0.0,
          (total, element) => total += element.totalPrice,
        )
        .currencyTPBR;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          _goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_bag_outlined),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Ver sacola",
                style: context.textStyles.textExtraBold.copyWith(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
