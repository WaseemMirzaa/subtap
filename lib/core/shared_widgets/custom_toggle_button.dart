// Add this custom toggle button widget
import 'package:flutter/material.dart';
import 'package:subtap/core/theme/app_color.dart';

class CustomToggleButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const CustomToggleButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColor.mutedGold : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : AppColor.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
