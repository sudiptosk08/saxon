import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/controller/products/product_details_controller.dart';
import 'package:saxonmarket/controller/products/state/product_details_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/views/global_components/k_button.dart';
import 'package:saxonmarket/views/screens/cart/cart_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String id;
  final String? thumbnail;
  final String? text;
  final String? price;
  final String? discountPrice;
  final ProductModel product;

  // ignore: use_key_in_widget_constructors
  const ProductDetailsScreen({
    Key? key,
    required this.id,
    this.thumbnail,
    this.text,
    this.price,
    this.discountPrice,
    required this.product,
  });

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<Map<String, dynamic>> colors1 = [
    {"color1": KColor.blue},
    {"color1": KColor.red},
    {"color1": KColor.seenGreen},
    {"color1": KColor.grey},
  ];
  List<Map<String, dynamic>> myOrder = [
    {"text": "XS"},
    {"text": "M"},
    {"text": "L"},
    {"text": "XL"},
  ];
  // ignore: prefer_typing_uninitialized_variables
  var selectColorIndex;
  // ignore: prefer_typing_uninitialized_variables
  var brandIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (builder, ref, _) {
        final productDetailState = ref.watch(productDetailsProvider);
        final product =
            ref.watch(productDetailsProvider.notifier).productDetailsModel;
        return Scaffold(
            backgroundColor: KColor.grey200,
            body: ((productDetailState is ProductDetailsLoadingState))
                ? shimmer()
                : ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Stack(children: [
                        Hero(
                          tag: product!.id.toString(),
                          child: Container(
                            key: UniqueKey(),
                            //height: MediaQuery.of(context).size.height * 0.50,
                            //width: double.infinity,
                            decoration: const BoxDecoration(
                              color: KColor.appBackground,
                            ),
                            child: AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Carousel(
                                boxFit: BoxFit.cover,
                                images: List.generate(
                                    3,
                                    (index) => Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                            image: NetworkImage(
                                                widget.product.thumbnail!),
                                            fit: BoxFit.cover,
                                          )),
                                        )),
                                borderRadius: true,
                                dotIncreaseSize: 2.0,
                                radius: const Radius.elliptical(2, 7),
                                dotBgColor: KColor.grey.withOpacity(0.0),
                                dotSize: 6.0,
                                autoplay: false,
                                animationCurve: Curves.easeInOut,
                                dotColor: KColor.white,
                                dotIncreasedColor: KColor.primary,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: CircleAvatar(
                            backgroundColor: KColor.white,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: KColor.appBarTitle,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              iconSize: 27,
                            ),
                          ),
                        ),
                        // Positioned(top: 10, right: 10, child: CircleAvatar(
                        //   backgroundColor: KColor.white,
                        //   child: KCartComponent())),
                        Positioned(
                            bottom: -45,
                            child: Container(
                              width: KSize.getWidth(context, 375),
                              height: 60,
                              decoration: BoxDecoration(
                                  color: KColor.grey200,
                                  // border:
                                  // Border.all(color: KColor.appBackground),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25))),
                            ))
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'BDT ${product.discountPrice}',
                                  style: KTextStyle.headline6.copyWith(
                                    color: KColor.primary,
                                  ),
                                ),
                                SizedBox(width: 8),
                                product.discountPrice.toString() !=
                                        product.price.toString()
                                    ? Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          'BDT ${product.price}',
                                          style: KTextStyle.headline6.copyWith(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              color: KColor.red),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: KColor.grey200,
                                  borderRadius: BorderRadius.circular(35),
                                  boxShadow: [
                                    BoxShadow(
                                      color: KColor.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              child: Icon(
                                Icons.favorite,
                                color: KColor.red,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name!,
                              style: KTextStyle.bodyText2
                                  .copyWith(color: KColor.accentColor),
                            ),
                            Text(
                              product.name!,
                              style: KTextStyle.headline5.copyWith(
                                  color: KColor.drawerItem,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SmoothStarRating(
                              size: 21,
                              spacing: 2,
                              borderColor: KColor.royalOrange,
                              color: KColor.royalOrange,
                              rating: product.rating!.toDouble(),
                              allowHalfRating: false,
                            ),
                            Row(children: [
                              //Product Color
                              /* Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 18,
                          ),
    
                          Text(
                            "KCOLOR",
                            style: KTextStyle.bodyText2.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: KColor.bodyTitle),
                          ),
                          SizedBox(
                            width: KSize.getWidth(context, 170),
                            height: KSize.getHeight(context, 75),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: [
                                ...List.generate(
                                    colors1.length,
                                    (index) => Padding(
                                        padding: const EdgeInsets.only(
                                            right: 6, top: 15),
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectColorIndex = index;
                                              });
                                            },
                                            child: Container(
                                                alignment: Alignment.center,
                                                height: 32,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                  color: colors1[index]['color1'],
                                                ),
                                                child: selectColorIndex == index
                                                    ? Icon(
                                                        Icons.check,
                                                        color: KColor.white,
                                                      )
                                                    : Container())))),
                              ]),
                            ),
                          ),
                        ],
                      ),*/
                              //const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Text(
                                    "SIZE",
                                    style: KTextStyle.bodyText1.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: KColor.bodyTitle),
                                  ),
                                  SizedBox(
                                    width: KSize.getWidth(context, 168),
                                    height: KSize.getHeight(context, 75),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(children: [
                                        ...List.generate(
                                            myOrder.length,
                                            (index) => Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 7, top: 14),
                                                child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        brandIndex = index;
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: 33,
                                                      width: 33,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(35),
                                                        color: brandIndex ==
                                                                index
                                                            ? KColor.primary
                                                            : KColor.secondary,
                                                      ),
                                                      child: Text(
                                                        myOrder[index]['text'],
                                                        style: KTextStyle
                                                            .bodyText2
                                                            .copyWith(
                                                                color: brandIndex ==
                                                                        index
                                                                    ? KColor
                                                                        .white
                                                                    : KColor
                                                                        .accentColor),
                                                      ),
                                                    )))),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ])
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Product Description",
                              style: KTextStyle.bodyText2.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: KColor.bodyTitle),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Another very popular suit product kicons fabric .Amar Sonar bangla",
                              style: KTextStyle.bodyText2
                                  .copyWith(color: KColor.accentColor),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                left: KSize.getHeight(context, 15),
                right: KSize.getHeight(context, 15),
                top: KSize.getHeight(context, 5),
                bottom: KSize.getHeight(context, 5),
              ),
              child: KButton(
                getWidth: KSize.getWidth(context, 180),
                getHeight: KSize.getHeight(context, 60),
                kbuttonTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute<void>(
                          builder: (BuildContext context) =>
                              const CartScreen()));
                },
                containerColor: KColor.primary,
                borderColor: KColor.primary,
                txtcolor: KColor.white,
                text: "ADD TO CART",
              ),
            ));
      },
    );
  }

  Widget shimmer() {
    return Container(
      color: KColor.white,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              Shimmer.fromColors(
                  child: AspectRatio(
                    aspectRatio:  1 / 0.98,
                    child: Container(
                    //  height: MediaQuery.of(context).size.height * 0.55,
                     // width: double.infinity,
                      child: ClipRRect(
                          child: FadeInImage(
                        image: AssetImage(AssetPath.placeholder),
                        placeholder: AssetImage(AssetPath.placeholder),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                  baseColor: KColor.white,
                  highlightColor: KColor.appBackground),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: KColor.appBarTitle,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 27,
                ),
              ),
              
            ],
          ),
          Container(
          //  height: MediaQuery.of(context).size.height * 0.80,
            decoration: BoxDecoration(
              color: KColor.grey200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Shimmer.fromColors(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 30,
                        child: Container(
                          color: KColor.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                        child: Container(
                          color: KColor.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 70,
                        child: Container(
                          color: KColor.white,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 70,
                        child: Container(
                          color: KColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                baseColor: KColor.white,
                highlightColor: KColor.appBackground),
          ),
        ],
      ),
    );
  }
}
