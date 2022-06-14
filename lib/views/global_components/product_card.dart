import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/products/product_details_controller.dart';
import 'package:saxonmarket/controller/products/state/product_details_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/views/screens/products/product_details_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.imagepaths,
    required this.text,
    required this.price,
    required this.discountPrice,
    required this.product,
  }) : super(key: key);
  final String imagepaths;
  final String text;
  final String price;
  final String discountPrice;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (builder, ref, _) {
        final productDetailsState = ref.watch(productDetailsProvider);
        return GestureDetector(
          onTap: () {
            if (!(productDetailsState is ProductDetailsLoadingState)) {
              ref
                  .watch(productDetailsProvider.notifier)
                  .fetchProductDetails(product.id!);
            }

            Navigator.push(
                context,
                CupertinoPageRoute<void>(
                    builder: (BuildContext context) => ProductDetailsScreen(
                          id: product.id.toString(),
                          thumbnail: product.thumbnail,
                          text: product.name,
                          price: product.price.toString(),
                          discountPrice: product.discountPrice.toString(),
                          product: product,
                        )));
          },
          child:
           Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: KSize.getHeight(context, 274),
               decoration: BoxDecoration(
                 color: KColor.grey100,
                borderRadius: BorderRadius.circular(10),
              boxShadow:[  BoxShadow(
                                      color: KColor.grey.withOpacity(0.5),
                                      spreadRadius: 0.5,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3),),
                 ],),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                         width: KSize.getWidth(context, 150),
                         height: KSize.getHeight(context, 165),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0),
                            topRight:  Radius.circular(7.0)),
                            image: DecorationImage(
                                image: NetworkImage(product.thumbnail!),
                                fit: BoxFit.cover)),
                        child: Stack(
                          children: const [
                            Positioned(
                              right: 5,
                              child: IconButton(
                                  onPressed: null,
                                  icon:
                                      Icon(Icons.favorite, color: KColor.primary),
                                  iconSize: 20),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: KSize.getHeight(context, 13)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(text,
                            style: KTextStyle.bodyText1
                                .copyWith(color: KColor.accentColor),
                                
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,),
                      ),
                      SizedBox(height: KSize.getHeight(context, 13)),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,bottom: 8),
                        child: Row(
                          children: [
                            Text('BDT ${product.discountPrice}',
                                style: KTextStyle.bodyText2
                                    .copyWith(color: KColor.primary)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text('BDT ${product.price}',
                                  style: KTextStyle.bodyText2.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: KColor.accentColor),maxLines: 1,
                                      overflow: TextOverflow.ellipsis,),
                            )
                          ],
                        ),
                      )
                    ]),
              )),
          
          //  Container(
          //     color: KColor.grey200,
          //     width: KSize.getWidth(context, 150),
          //     height: KSize.getHeight(context, 287),
          //     child: Column(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Stack(
          //             children: [
          //               KImageView(imagepaths: product.thumbnail!),
          //               Positioned(
          //                 right: 5,
          //                 child: IconButton(
          //                     onPressed: null,
          //                     icon: Icon(Icons.favorite_sharp,
          //                         color: KColor.primary),
          //                     iconSize: 20),
          //               )
          //             ],
          //           ),
          //           Text(text,
          //               style: KTextStyle.bodyText1
          //                   .copyWith(color: KColor.accentColor)),
          //           Row(
          //             children: [
          //               Text('BDT ${product.discountPrice}',
          //                   style: KTextStyle.bodyText2
          //                       .copyWith(color: KColor.primary)),
          //               SizedBox(width: 8),
          //               Expanded(
          //                 child: Text('BDT ${product.price}',
          //                     style: KTextStyle.bodyText2.copyWith(
          //                         decoration: TextDecoration.lineThrough,
          //                         color: KColor.accentColor)),
          //               )
          //             ],
          //           )
          //         ])),
        );
      },
    );
  }
}
