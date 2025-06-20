import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subtap/controller/navigation_controller.dart';
import 'package:subtap/core/bindings.dart/binding.dart';
import 'package:subtap/core/config/config.dart';
import 'package:subtap/core/theme/app_color.dart';

void main() {
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Subtap',
      theme: AppColor.darkTheme,
      initialBinding: AppBinding(),
      getPages: AppRouter().getPages,
      initialRoute: AppRoutes.splash,
      debugShowCheckedModeBanner: false,
    );
  }
}
