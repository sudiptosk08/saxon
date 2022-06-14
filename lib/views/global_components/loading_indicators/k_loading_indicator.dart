import 'package:flutter/material.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class KLoadingIndicator extends StatelessWidget {
  final Color backgroundColor, valueColor;
  final double strokeWidth;

   KLoadingIndicator({this.backgroundColor = KColor.greybg, this.valueColor = KColor.greybg, this.strokeWidth = 2.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor.withOpacity(0.3),
        valueColor: AlwaysStoppedAnimation<Color>(valueColor.withOpacity(0.4)),
      ),
    );
  }
}
