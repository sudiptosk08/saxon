import 'package:flutter/material.dart';
import 'package:saxonmarket/views/styles/k_colors.dart';

import 'k_cart_component.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  // ignore: use_key_in_widget_constructors
  const KAppBar({
    Key? key,
    this.text,
    this.leadingicon,
    this.leadiconpress,
    this.sufixiconpress,
    this.sufixicon,
    this.prefixicon,
    this.prefixiconpress,
    this.kToolbarHeight,
    this.elevation,
    this.color = KColor.white,
    this.cartIconRequired = true,
    this.suffixIconRequired = false,
  }) : preferredSize = const Size.fromHeight(60);
  final String? text;
  final IconData? leadingicon;
  final Color color;
  final IconData? sufixicon;
  final IconData? prefixicon;
  final GestureTapCallback? leadiconpress;
  final GestureTapCallback? sufixiconpress;
  final GestureTapCallback? prefixiconpress;
  final double? kToolbarHeight;
  final double? elevation;
  final bool? cartIconRequired;
  final bool? suffixIconRequired;
  // ignore: non_constant_identifier_names
  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Builder(builder: (context) {
                  return IconButton(
                    onPressed: leadiconpress,
                    icon: Icon(
                      leadingicon,
                      color: KColor.appBarTitle,
                    ),
                    iconSize: 25,
                  );
                }),
              ),
              Row(
                children: [
                  suffixIconRequired!
                      ? Container(
                          child: Builder(builder: (context) {
                            return IconButton(
                              onPressed: sufixiconpress,
                              icon: Icon(
                                sufixicon,
                                color: KColor.appBarTitle,
                              ),
                              iconSize: 25,
                            );
                          }),
                        )
                      : Container(),
                  cartIconRequired! ? KCartComponent() : Container(),
                ],
              )
            ],
          ),
        ],
      ),
      elevation: 0,
    );
  }
}
