import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subtap/core/theme/app_color.dart';

class CustomTextField extends StatefulWidget {
  final bool enabled;
  final int? maxLines;
  final bool readOnly;
  final int? maxLength;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  final bool obscureText;
  final int? errorMaxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final Color? textColor;
  final String? initialValue;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final FocusNode? focusNode;
  final bool showPasswordToggle;
  final EdgeInsets? contentPadding;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color borderColor;
  final Color fillColor;
  final String? fieldHeading;
  final String? leftLabel;
  final double? height;
  final double? width;
  final bool autofocus;
  final Color? passwordToggleIconColor;
  final Color? hintTextColor;
  final bool isCircular;
  final double? circularRadius;
  final FontStyle? fontStyle;
  final bool showRightDot;
  final Color? rightDotColor;
  final double? rightDotSize;
  final double? rightDotBorderWidth;

  const CustomTextField({
    super.key,
    this.onTap,
    this.prefix,
    this.suffix,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.focusNode,
    this.hintStyle,
    this.onChanged,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.borderRadius,
    this.keyboardType,
    this.errorMaxLines,
    this.enabled = true,
    this.contentPadding,
    this.inputFormatters,
    this.readOnly = false,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.textAlign = TextAlign.start,
    this.textColor = AppColor.mutedBlueShade,
    this.textInputAction = TextInputAction.go,
    this.borderColor = Colors.grey,
    this.fillColor = Colors.white,
    this.fieldHeading,
    this.leftLabel,
    this.height,
    this.width,
    this.autofocus = false,
    this.passwordToggleIconColor = AppColor.white,
    this.isCircular = false,
    this.circularRadius,
    this.fontStyle,
    this.hintTextColor,
    this.showRightDot = false,
    this.rightDotColor = Colors.black,
    this.rightDotSize = 12,
    this.rightDotBorderWidth = 1.5,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.showPasswordToggle || widget.obscureText) {
      _obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = widget.height ?? (widget.isCircular ? 40.0 : 55.0);
    final effectiveBorderRadius = widget.isCircular
        ? widget.circularRadius ?? effectiveHeight / 2
        : widget.borderRadius ?? 15.0;
    final effectiveWidth = widget.isCircular ? effectiveHeight : widget.width;

    // Build the right circle-with-dot indicator
    Widget? rightDotWidget;
    if (widget.showRightDot) {
      rightDotWidget = Container(
        margin: const EdgeInsets.only(left: 8), // Space between elements
        width: widget.rightDotSize,
        height: widget.rightDotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.lightGray, // Background color for the outer circle
          border: Border.all(
            color: widget.rightDotColor ?? Colors.black, // Black outline
            width: widget.rightDotBorderWidth ?? 2.0,
          ),
        ),
        child: Center(
          child: Container(
            width:
                (widget.rightDotSize ?? 14) * 0.5, // Inner dot is half the size
            height: (widget.rightDotSize ?? 14) * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.rightDotColor ?? Colors.black, // Inner dot color
            ),
          ),
        ),
      );
    }

    // Combine all right-side widgets
    final rightWidgets = <Widget>[];

    // Add password toggle if needed
    if (widget.showPasswordToggle) {
      rightWidgets.add(
        IconButton(
          onPressed: () => setState(() => _obscureText = !_obscureText),
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: widget.passwordToggleIconColor,
          ),
        ),
      );
    }

    // Add custom suffix icon if provided
    else if (widget.suffixIcon != null) {
      rightWidgets.add(widget.suffixIcon!);
    }

    // Add the permanent dot if enabled
    if (widget.showRightDot) {
      rightWidgets.add(rightDotWidget!);
    }

    // Build the final suffix icon
    final suffixIcon = rightWidgets.isNotEmpty
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: rightWidgets,
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.fieldHeading != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.fieldHeading!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.whiteSmoke,
              ),
            ),
          ),
        SizedBox(
          height: effectiveHeight,
          width: effectiveWidth,
          child: TextFormField(
            onTap: widget.onTap,
            enabled: widget.enabled,
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            obscureText: _obscureText,
            cursorColor: AppColor.black,
            textAlign: widget.textAlign,
            maxLength: widget.maxLength,
            focusNode: widget.focusNode,
            validator: widget.validator,
            onChanged: widget.onChanged,
            controller: widget.controller,
            initialValue: widget.initialValue,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            onEditingComplete: widget.onEditingComplete ??
                () {
                  if (widget.textInputAction?.name == 'go' ||
                      widget.textInputAction?.name == 'next') {
                    FocusManager.instance.primaryFocus?.nextFocus();
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
            autofocus: widget.autofocus,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              fontStyle: widget.fontStyle ?? FontStyle.italic,
              color: widget.textColor,
            ),
            decoration: InputDecoration(
              prefix: widget.prefix,
              suffix: widget.suffix,
              counterText: '',
              prefixIcon: widget.prefixIcon,
              suffixIcon: suffixIcon,
              hintText: widget.hintText ?? widget.leftLabel,
              errorMaxLines: widget.errorMaxLines,
              contentPadding: widget.contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: widget.isCircular ? effectiveHeight / 3 : 16,
                    vertical: widget.isCircular ? 0 : 15,
                  ),
              errorStyle: const TextStyle(color: Colors.red),
              hintStyle: widget.hintStyle ??
                  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: widget.hintTextColor ?? AppColor.whiteSmoke,
                    fontFamily: widget.fontStyle == FontStyle.normal
                        ? 'HelveticaNeueLight'
                        : 'HelveticaNeueLightItalic',
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(effectiveBorderRadius),
              ),
              fillColor: widget.fillColor,
              filled: true,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }
}
