import 'package:delivery_app/app/android_delivery_app.dart';
import 'package:delivery_app/app/core/config/env/env.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Env.instance.load();
  runApp(AndroidDeliveryApp());
}
