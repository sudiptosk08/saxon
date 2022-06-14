import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/controller/auth/user_controller.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/screens/cart/component/shoppingcart_card.dart';
import 'package:saxonmarket/views/screens/auth/login_screen.dart';
import 'package:saxonmarket/views/screens/payment/payment_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  List<Map<String, dynamic>> cart = [
    {
      'onPressed': () {},
      'selectedColor': KColor.black,
      'titleText': 'Denill Casual',
      'subtitleText': 'Girls Sneaker shoes',
      'colorText': 'Black',
      'sizeText': 'XL',
      'price': 'EGP 250',
      'productcount': 1,
      'imagePath': AssetPath.bag
    },
    {
      'onPressed': () {},
      'selectedColor': KColor.blue,
      'titleText': 'Denill Casual Shoes',
      'subtitleText': 'Boys convers shoes',
      'colorText': 'Blue',
      'sizeText': 'M',
      'price': 'EGP 200',
      'productcount': 3,
      'imagePath': AssetPath.bag
    },
    {
      'onPressed': () {},
      'selectedColor': KColor.red,
      'titleText': 'Casual Shirt',
      'subtitleText': 'Full coton shirts for man with replacement granty ',
      'colorText': 'Red',
      'sizeText': 'M',
      'price': 'EGP 190',
      'productcount': 2,
      'imagePath': AssetPath.bag,
    },
  ];
  var count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.white,
      appBar: KAppBar(
        leadingicon: Icons.arrow_back,
        leadiconpress: () => Navigator.pop(context),
        cartIconRequired:false,
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    top: 10,
                  ),
                  child: Text("Cart",
                      style: KTextStyle.headline4
                          .copyWith(color: KColor.bodyTitle)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cart.length,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        background: Container(
                          padding: EdgeInsets.only(right:15,bottom: 15),
                          alignment: Alignment.centerRight,
                          child: Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: KColor.royalOrange,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.trashAlt,
                                size: 18,
                                color: KColor.white,
                              )),
                        ),
                        key: ValueKey<int>(index),
                        onDismissed: (DismissDirection direction) {
                          setState(() {
                            cart.removeAt(index);
                          });
                        },
                        child: ShoppingCard(
                         
                          selectedColor: cart[index]['selectedColor'],
                          titleText: cart[index]['titleText'],
                          subtitleText: cart[index]['subtitleText'],
                          colorText: cart[index]['colorText'],
                          sizeText: cart[index]['sizeText'],
                          price: cart[index]['price'],
                          productcount: cart[index]['productcount'],
                          imagePath: cart[index]['imagePath'],
                        ));
                  },
                ),
              ])),

      /// Code snippet of UI when cart's empty
      // Center(
      //   child: Column(
      //     children: [
      //       Image.asset(AssetPath.shoppingcart, color: KColor.primary),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 15),
      //         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //           Text(
      //             "YALLA.",
      //             style: KTextStyle.headline4.copyWith(color: KColor.primary),
      //           ),
      //           SizedBox(height: KSize.getHeight(context, 15)),
      //           Text(
      //             "Fill your Cart Now from our Products",
      //             style: KTextStyle.bodyText2.copyWith(color: Colors.grey),
      //           ),
      //         ]),
      //       ),
      //     ],
      //   ),
      // ),
      //],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: KButton(
          containerColor: KColor.primary,
          borderColor: KColor.primary,
          getHeight: 55,
          getWidth: 200,
          kbuttonTap: () {
            if (ref.read(userProvider.notifier).userData == null) {
              toast('Login to continue', bgColor: KColor.red);
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => LoginScreen()));
            } else {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => PaymentScreen()));
            }
          },
          txtcolor: KColor.white,
          text: "PROCEED TO CHECKOUT", // Coutinue Shopping
        ),
      ),
    );
  }
 }
