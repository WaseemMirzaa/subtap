import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:subtap/controller/splash_controller.dart';
import 'package:subtap/core/theme/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    debugPrint('SplashPage build called, controller: ${controller.hashCode}');
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(
          Assets.imagesLogo,
          width: screenWidth * 0.9, // 80% of screen width
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
