import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final String expandText;
  final String collapseText;
  final Color? linkColor;

  const ExpandableText(
    this.text, {
    super.key,
    this.maxLines = 2,
    this.style,
    this.expandText = 'more',
    this.collapseText = 'less',
    this.linkColor,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveTextStyle = widget.style ?? const TextStyle();
    final colorClickableText = widget.linkColor ?? Colors.blue;

    return LayoutBuilder(builder: (context, size) {
      final TextSpan textSpan = TextSpan(
        text: widget.text,
        style: effectiveTextStyle,
      );

      final TextPainter textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        maxLines: widget.maxLines,
      );
      textPainter.layout(maxWidth: size.maxWidth);

      if (textPainter.didExceedMaxLines) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: effectiveTextStyle,
              maxLines: _expanded ? null : widget.maxLines,
              overflow: _expanded ? null : TextOverflow.ellipsis,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              child: Text(
                _expanded ? widget.collapseText : widget.expandText,
                style: effectiveTextStyle.copyWith(
                  color: colorClickableText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      } else {
        return Text(
          widget.text,
          style: effectiveTextStyle,
        );
      }
    });
  }
}