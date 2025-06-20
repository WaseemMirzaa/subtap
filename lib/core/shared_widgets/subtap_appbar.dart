import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:subtap/core/theme/app_color.dart';

class SubtapAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String? title;
  final String? svgAssetPath;
  final String? avatarAssetPath;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final EdgeInsets? padding;
  final VoidCallback? onAvatarPressed;
  final bool roundedBottomCorners;
  final Widget? bottom;

  const SubtapAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.title,
    this.svgAssetPath,
    this.avatarAssetPath,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.titleStyle,
    this.padding,
    this.onAvatarPressed,
    this.roundedBottomCorners = true,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.backgroundColor,
        borderRadius: roundedBottomCorners
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              )
            : null,
      ),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Add spacing above the title
          const SizedBox(
            height: 1,
          ), // Adjust this value to move the title lower
          // Top row with title and icons
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                leading ??
                    (svgAssetPath != null
                        ? SvgPicture.asset(
                            svgAssetPath!,
                            height: 24,
                          )
                        : const SizedBox.shrink()),
                if (title != null)
                  Text(
                    title!,
                    style: titleStyle ??
                        Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                if (avatarAssetPath != null || actions != null)
                  Row(
                    children: [
                      if (actions != null) ...actions!,
                      if (avatarAssetPath != null)
                        IconButton(
                          onPressed: onAvatarPressed,
                          icon: CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(avatarAssetPath!),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          // Bottom content
          if (bottom != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: bottom!,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
