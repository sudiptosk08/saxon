import 'package:flutter/material.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:shimmer/shimmer.dart';

class KFieldLoadingIndicator extends StatefulWidget {
  @override
  _KFieldLoadingIndicatorState createState() => _KFieldLoadingIndicatorState();
}

class _KFieldLoadingIndicatorState extends State<KFieldLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Shimmer.fromColors(
        baseColor: KColor.greybg.withOpacity(0.65),
        highlightColor: KColor.greybg.withOpacity(0.15),
        enabled: true,
        child: Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: KColor.greybg,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
