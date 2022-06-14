import 'package:flutter/material.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class NoProductFound extends StatelessWidget {
  const NoProductFound({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        alignment: Alignment.center,
        height: KSize.getHeight(context, 250),
        child: Column(
          children: [
            Container(
              height: KSize.getHeight(context, 150),
              width: KSize.getHeight(context, 150),
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(AssetPath.noProductIcon), fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'No Product Found',
              style: KTextStyle.headline3.copyWith(color: KColor.textFieldLabel, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}