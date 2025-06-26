import 'package:flutter/material.dart';
import 'package:subtap/core/shared_widgets/custom_text.dart';
import 'package:subtap/core/theme/app_color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onTap;
  final double width;
  final double height;
  final bool enableBorder;
  final Color? borderColor;
  final Color? color;
  final LinearGradient? gradient;
  final Color textColor;
  final double radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool enableIcon;
  final Widget? icon;
  final bool isLoading;
  final Color? loadingColor;
  final String? fontFamily; // NEW: Font family parameter

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width = double.infinity,
    this.height = 45,
    this.radius = 100,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w600,
    this.borderColor,
    this.color = AppColor.mutedGold,
    this.gradient,
    this.textColor = Colors.white,
    this.enableBorder = false,
    this.enableIcon = false,
    this.icon,
    this.isLoading = false,
    this.loadingColor = Colors.white,
    this.fontFamily, // NEW: Optional font family
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Center(
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: gradient == null
                ? (isLoading ? color?.withOpacity(0.7) : color)
                : null,
            gradient: gradient,
            borderRadius: BorderRadius.circular(radius),
            border: enableBorder
                ? Border.all(color: borderColor ?? Colors.transparent)
                : null,
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(loadingColor!),
                      strokeWidth: 2,
                    ),
                  )
                : enableIcon
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) ...[
                            icon!,
                            const SizedBox(width: 8)
                          ],
                          Flexible(
                            child: CustomText(
                              text: text,
                              color: textColor,
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: fontFamily,
                              maxLines: 1, // Pass to CustomText
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: CustomText(
                          text: text,
                          color: textColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          fontFamily: fontFamily,
                          // Pass to CustomText
                        ),
                      ),
          ),
        ),
      ),
    );
  }
}
