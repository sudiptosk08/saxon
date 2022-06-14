import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/screens/payment/payment_successfull_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<Map<String, dynamic>> images = [
    {"image": AssetPath.visacard},
    // {"image": AssetPath.visacard},
    // {"image": AssetPath.visacard},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      appBar: KAppBar(
        leadingicon: Icons.arrow_back,
        leadiconpress: () => Navigator.pop(context),
        cartIconRequired: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: KSize.getWidth(context, 20), top: 5, bottom: 10),
                  child: Text(
                    "Payment",
                    style: KTextStyle.headline4.copyWith(color: KColor.bodyTitle),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(KSize.getWidth(context, 15)),
                  child: Container(
                    key: UniqueKey(),
                    height: KSize.getHeight(context, 230),
                    width: double.infinity,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Carousel(
                      boxFit: BoxFit.fill,
                      images: List.generate(
                          images.length,
                          (index) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "${images[index]['image']}",
                                      ),
                                      fit: BoxFit.fitWidth,
                                    )),
                              )),
                      borderRadius: true,
                      dotIncreaseSize: 1.0,
                      radius: const Radius.circular(12),
                      dotBgColor: KColor.grey.withOpacity(0.0),
                      dotSize: 5.0,
                      autoplay: false,
                      animationCurve: Curves.easeInOut,
                      dotColor: KColor.grey,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "SubTotal",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "\$${26}",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Discount",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "%${26}",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Shipping",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "\$${26}",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Estimate Tax",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "\$${26}",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.accentColor, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 8.0, right: 20, bottom: 12),
                    child: Divider(
                      color: KColor.grey,
                      height: 4,
                      endIndent: 3,
                      indent: 3,
                      thickness: 0.7,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.drawerItem, fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "\$${26}",
                            style: KTextStyle.bodyText1.copyWith(color: KColor.drawerItem, fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                KButton(
                  getWidth: KSize.getWidth(context, 359),
                  getHeight: KSize.getHeight(context, 65),
                  text: "Add Card",
                  containerColor: KColor.white,
                  borderColor: KColor.grey,
                  txtcolor: KColor.grey,
                ),
                const SizedBox(height: 10),
                KButton(
                  getWidth: KSize.getWidth(context, 359),
                  getHeight: KSize.getHeight(context, 65),
                  text: "Checkout",
                  containerColor: KColor.primary,
                  borderColor: KColor.primary,
                  txtcolor: KColor.white,
                  kbuttonTap: () {
                      Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const PaymentSuccessfull()));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
