import 'package:delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../core/ui/widgets/delivery_button.dart';

class OrderCompletedPaga extends StatelessWidget {
  const OrderCompletedPaga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(.2),
              ),
              Image.asset('assets/images/logo_rounded.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Seu pedido foi realizado com sucesso",
                textAlign: TextAlign.center,
                style: context.textStyles.textExtraBold.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              DeliveryButton(
                width: context.percentWidth(.8),
                label: "Fechar",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
