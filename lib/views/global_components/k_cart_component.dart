import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxonmarket/views/screens/cart/cart_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class KCartComponent extends StatefulWidget {
  final bool isHomePage;
  const KCartComponent({
    Key? key,
    this.isHomePage = false,
  }) : super(key: key);

  @override
  State<KCartComponent> createState() => _KCartComponentState();
}

class _KCartComponentState extends State<KCartComponent> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CartScreen()));
      },
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_bag_rounded, size: 25, color: widget.isHomePage ? KColor.white : KColor.black)),
          Positioned(
            top: 1,
            right: 1,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(color: widget.isHomePage ? KColor.orange400 : KColor.primary, shape: BoxShape.circle),
              child: Text(
                '2',
                style: KTextStyle.overline.copyWith(color: KColor.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
