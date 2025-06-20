import 'package:flutter/material.dart';
import 'package:subtap/core/theme/app_color.dart';

class SubtapScaffold extends StatelessWidget {
  final Widget body;
  final bool isAppBar;
  final PreferredSizeWidget? appBarSecond;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  const SubtapScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.isAppBar = false,
    this.drawer,
    this.appBarSecond,
    this.bottomNavigationBar,
    this.backgroundColor = AppColor.lightGray,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: isAppBar ? appBarSecond : appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      body: body,
    );
  }
}
