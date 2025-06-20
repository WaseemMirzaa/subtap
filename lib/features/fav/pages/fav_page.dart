import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/subtap_scaffold.dart';
import 'package:subtap/core/theme/app_color.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubtapScaffold(
      body: Center(
        child: Text(
          'Fav',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.black),
        ),
      ),
    );
  }
}
