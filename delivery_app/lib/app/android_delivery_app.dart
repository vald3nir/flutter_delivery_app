import 'package:delivery_app/app/core/global/global_context.dart';
import 'package:delivery_app/app/core/global/global_strings.dart';
import 'package:delivery_app/app/core/global/glogal_router.dart';
import 'package:delivery_app/app/core/providers/application_binding.dart';
import 'package:delivery_app/app/core/ui/theme/theme_config.dart';
import 'package:flutter/material.dart';

class AndroidDeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  AndroidDeliveryApp({super.key}) {
    GlobalContext.instance.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: GlobalStrings.appName,
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        routes: GlogalRouter.routers(context),
      ),
    );
  }
}
