// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:saxonmarket/views/styles/k_colors.dart';
import 'package:saxonmarket/views/styles/k_size.dart';
import 'package:saxonmarket/views/styles/k_text_style.dart';

class ShoppingCard extends StatefulWidget {
 // GestureDetector onPressed;
  Color? selectedColor;
  String? titleText;
  String? subtitleText;
  String? colorText;
  String? sizeText;
  String? price;
  int? productcount;
  String? imagePath;
   ShoppingCard({
    Key? key,
    this.selectedColor,
    this.titleText,
    this.subtitleText,
    this.colorText,
    this.sizeText,
    this.price,
    this.productcount,
    this.imagePath,
  }) : super(key: key);

  @override
  _ShoppingCardState createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  var count ;
  @override
  void initState() {
    
    super.initState();
    count = widget.productcount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: KSize.getWidth(context, 345),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: KSize.getWidth(context, 115),
              width: KSize.getHeight(context, 115),
              decoration: BoxDecoration(
                  color: const Color(0xFF5F5D70),
                  image: DecorationImage(
                      image: AssetImage(widget.imagePath!), fit: BoxFit.fill)),
            ),
            Container(
              width: KSize.getWidth(context, 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.titleText!,
                    style:
                        KTextStyle.subtitle2.copyWith(color: KColor.accentColor),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.subtitleText!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: KTextStyle.drawer.copyWith(
                      color: KColor.drawerItem,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 27,
                        width: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: widget.selectedColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.colorText!,
                          style: KTextStyle.bodyText1
                              .copyWith(fontSize: 14, color: KColor.drawerItem)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "|",
                        style: KTextStyle.bodyText1
                            .copyWith(color: KColor.grey, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text.rich(TextSpan(
                          text: "SIZE:",
                          style: KTextStyle.bodyText1
                              .copyWith(fontSize: 14, color: KColor.accentColor),
                          children: [
                            TextSpan(
                                text: widget.sizeText,
                                style: KTextStyle.bodyText1.copyWith(
                                    fontSize: 14, color: KColor.drawerItem))
                          ]))
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(widget.price!,
                      style: KTextStyle.bodyText1.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: KColor.primary))
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                       print("${widget.productcount}");                      
                       count++;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: KColor.searchBarTitle,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 12,
                      ),
                    )),
                const SizedBox(height: 5),
                Container(
                    alignment: Alignment.center,
                    height: 27,
                    width: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: KColor.primary,
                    ),
                    child: Text(count.toString())),
                const SizedBox(height: 5),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        count == 1 ? count = 1 :
                        --count;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 27,
                      width: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: KColor.accentColor,
                      ),
                      child: Text(
                        "-",
                        style: KTextStyle.headline6,
                      ),
                    )),
              ],
            )
          ]),
        ),
        Divider(
          color: KColor.grey,
          endIndent: 0,
          height: 30,
          indent: 15,
          thickness: 1,
        ),
      ],
    );
  }
}
