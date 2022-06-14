import 'package:flutter/material.dart';
import 'package:saxonmarket/views/global_components/loading_indicators/k_loading_indicator.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class KProcessingDialogContent extends StatelessWidget {
  final String text;
  const KProcessingDialogContent(this.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: KColor.greybg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            KLoadingIndicator(),
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                text,
                style: KTextStyle.subtitle1,
                textAlign: TextAlign.start,
              ),
            )
          ],
        ));
  }
}
