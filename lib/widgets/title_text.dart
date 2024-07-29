import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget(
      {super.key,
      required this.label,
      this.fontSize = 18,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.bold,
      this.color,
      this.textDecoration = TextDecoration.none,
      this.maxLines});

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration textDecoration;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
