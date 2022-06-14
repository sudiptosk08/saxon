import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/screens/auth/create_address_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class ShippingAddressSelectionScreen extends StatefulWidget {
  const ShippingAddressSelectionScreen({Key? key}) : super(key: key);

  @override
  _ShippingAddressSelectionScreenState createState() => _ShippingAddressSelectionScreenState();
}

class _ShippingAddressSelectionScreenState extends State<ShippingAddressSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      appBar: KAppBar(
        leadingicon: Icons.arrow_back,
        leadiconpress: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "Shipping To",
              style: KTextStyle.headline4.copyWith(color: KColor.bodyTitle),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(
                  2,
                  (index) => shippingAddressSelectionScreenBox(
                      onPressed: () {},
                      iconColor: KColor.grey,
                      titleText: "446 Sheikh Mohammed Rashed Bangladesh",
                      subtitleText: "Down Town Dubai,31166",
                      subtitleText2: "Dubai - United Arab Emirates")),
              const SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.all(20),
                child: KButton(
                  getHeight: KSize.getHeight(context, 65),
                  getWidth: KSize.getWidth(context, 359),
                  kbuttonTap: () {
                    Navigator.push(context, CupertinoPageRoute<void>(builder: (BuildContext context) => const CreateAddressScreen()));
                  },
                  containerColor: KColor.primary,
                  borderColor: KColor.primary,
                  text: "ADD NEW ADDRESS",
                  txtcolor: KColor.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget shippingAddressSelectionScreenBox({
    required GestureTapCallback onPressed,
    required Color iconColor,
    required String titleText,
    required String subtitleText,
    required String subtitleText2,
  }) =>
      Stack(children: [
        Padding(
          padding: EdgeInsets.only(
            left: KSize.getWidth(context, 15),
            top: KSize.getWidth(context, 15),
            right: KSize.getWidth(context, 10),
          ),
          child: Container(
            width: KSize.getWidth(context, 336),
            height: KSize.getHeight(context, 150),
            decoration: BoxDecoration(
              color: KColor.shippingBox,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 14.0,
                  ),
                  child: IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.check_circle,
                      color: iconColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                        style: KTextStyle.subtitle1.copyWith(
                          fontWeight: FontWeight.w800,
                          color: KColor.drawerItem,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        subtitleText,
                        style: KTextStyle.subtitle2.copyWith(color: KColor.accentColor),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        subtitleText2,
                        style: KTextStyle.subtitle2.copyWith(color: KColor.accentColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            right: KSize.getWidth(context, -12),
            top: KSize.getHeight(context, -3),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.remove_circle,
                color: KColor.primary,
                size: 28,
              ),
            ))
      ]);
}
