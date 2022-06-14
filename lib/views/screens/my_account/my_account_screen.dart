import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/controller/auth/user_controller.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/screens/my_account/update_profile_screen.dart';

import 'package:saxonmarket/views/screens/payment/payment_screen.dart';
import 'package:saxonmarket/views/screens/shipping/shipping_address_selection_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      appBar: KAppBar(
        leadiconpress: () {
          Navigator.pop(context);
        },
        leadingicon: Icons.arrow_back,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 10),
            child: Text(
              "My Account",
              style: KTextStyle.headline4.copyWith(color: KColor.bodyTitle),
            ),
          ),
          const SizedBox(height: 20),
          Consumer(builder: (context, ref, _) {
            // need to watch this state so it updates with profile
            // ignore: unused_local_variable
            final userState = ref.watch(userProvider);
            final userData = ref.watch(userProvider.notifier).userData;
            return Row(
              children: [
                const SizedBox(width: 15),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(AssetPath.profile)), color: KColor.primary, borderRadius: BorderRadius.circular(45)),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData!.name!,
                      style: KTextStyle.drawer.copyWith(color: KColor.drawerItem, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userData.email!,
                      style: KTextStyle.bodyText2.copyWith(fontSize: 14, color: KColor.accentColor),
                    ),
                  ],
                )
              ],
            );
          }),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => const UpdateProfile()));
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: KColor.drawerItem,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Profile",
                          style: KTextStyle.bodyText2.copyWith(color: KColor.drawerItem),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: KColor.accentColor,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: KColor.grey,
            thickness: 0.8,
            endIndent: 30,
            indent: 30,
            height: 5,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_sharp,
                          color: KColor.drawerItem,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text("WishList",
                            style: KTextStyle.bodyText2.copyWith(
                              color: KColor.drawerItem,
                            )),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: KColor.accentColor,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: KColor.grey,
            thickness: 0.8,
            endIndent: 30,
            indent: 30,
            height: 5,
          ),
          InkWell(
            onTap: (){},
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.library_add,
                          color: KColor.drawerItem,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Orders",
                          style: KTextStyle.bodyText2.copyWith(color: KColor.drawerItem),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: KColor.accentColor,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: KColor.grey,
            thickness: 0.8,
            endIndent: 30,
            indent: 30,
            height: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute<void>(builder: (BuildContext context) => const ShippingAddressSelectionScreen()));
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: KColor.drawerItem,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Address",
                          style: KTextStyle.bodyText2.copyWith(color: KColor.drawerItem),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: KColor.accentColor,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: KColor.grey,
            thickness: 0.8,
            endIndent: 30,
            indent: 30,
            height: 5,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, CupertinoPageRoute<void>(builder: (BuildContext context) => const PaymentScreen()));
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.payment,
                          color: KColor.drawerItem,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Payment",
                          style: KTextStyle.bodyText2.copyWith(color: KColor.drawerItem),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: KColor.accentColor,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: KColor.grey,
            thickness: 0.8,
            endIndent: 30,
            indent: 30,
            height: 5,
          ),
          InkWell(
            onTap:(){},
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.keyboard_return,
                          color: KColor.drawerItem,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Returns",
                          style: KTextStyle.bodyText2.copyWith(color: KColor.drawerItem),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 48.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: KColor.accentColor,
                            size: 20,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: KColor.grey,
            thickness: 0.8,
            endIndent: 30,
            indent: 30,
            height: 5,
          ),
        ],
      ),
    );
  }
}
