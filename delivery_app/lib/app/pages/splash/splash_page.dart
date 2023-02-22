import 'package:delivery_app/app/core/global/global_image.dart';
import 'package:delivery_app/app/core/global/global_strings.dart';
import 'package:delivery_app/app/core/global/glogal_router.dart';
import 'package:delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ColoredBox(
        color: const Color(0XFF140E0E),
        child: Stack(
          children: [
            logoComponent(context),
            bodyComponent(context),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Components Screen
  // ---------------------------------------------------------------------------

  Widget logoComponent(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
          width: context.screenWidth,
          child: Image.asset(
            GlobalImage.snackPath,
            fit: BoxFit.cover,
          )),
    );
  }

  Widget bodyComponent(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: context.percentHeight(.30)),
          Image.asset(GlobalImage.logoPath),
          const SizedBox(height: 80),
          DeliveryButton(
            label: GlobalStrings.confirmButtonLabel,
            height: 35,
            width: context.percentWidth(.6),
            onPressed: () {
              GlogalRouter.navigateToHome(context);
            },
          ),
        ],
      ),
    );
  }
}
