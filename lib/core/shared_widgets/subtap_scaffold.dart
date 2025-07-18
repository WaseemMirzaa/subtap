import 'package:flutter/material.dart';
import 'package:subtap/core/theme/app_color.dart';

class SubtapScaffold extends StatelessWidget {
  final Widget body;
  final bool isAppBar;
  final PreferredSizeWidget? appBarSecond;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backgroundColor;

  const SubtapScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.isAppBar = false,
    this.drawer,
    this.appBarSecond,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backgroundColor = AppColor.lightGray,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: isAppBar ? appBarSecond : appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: body,
    );
  }
}
