import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/pagination/products/products_by_category_scroll_provider.dart';
import 'package:saxonmarket/controller/pagination/products/products_by_keyword_scroll_provider.dart';
import 'package:saxonmarket/controller/pagination/scroll_state.dart';
import 'package:saxonmarket/controller/products/products_by_category.dart';
import 'package:saxonmarket/controller/products/products_by_keyword_controller.dart';
import 'package:saxonmarket/controller/products/state/products_by_category_state.dart';
import 'package:saxonmarket/controller/products/state/products_by_keyword_state.dart';
import 'package:saxonmarket/models/product_model.dart';
import 'package:saxonmarket/views/global_components/all_product.dart';
import 'package:saxonmarket/views/global_components/k_appbar.dart';
import 'package:saxonmarket/views/global_components/k_no_product_found.dart';
import 'package:saxonmarket/views/global_components/k_shimmer_card.dart';
import 'package:saxonmarket/views/global_components/loading_indicators/k_loading_indicator.dart';
import 'package:saxonmarket/views/screens/filterpage/filterpage.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:shimmer/shimmer.dart';

class ProductsListScreen extends StatefulWidget {
  final String title;
  final bool? isNewCollectionProducts;
  final bool? fromCategoriesPage;
  final int? categoryId;
  const ProductsListScreen({
    Key? key,
    required this.title,
    this.isNewCollectionProducts = false,
    this.fromCategoriesPage = false,
    this.categoryId,
  }) : super(key: key);

  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late List<ProductModel> productList;
  late ScrollState state;
  late ScrollController _scrollController;

  final GlobalKey _contentKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (bulder, ref, _) {
        if (!widget.fromCategoriesPage!) {
          state = ref.watch(productsByKeywordScrollProvider);

          _scrollController =
              ref.read(productsByKeywordScrollProvider.notifier).controller;

          if (widget.isNewCollectionProducts!) {
            productList = ref
                .watch(productsByKeywordProvider.notifier)
                .newArrivalProducts!;
          } else {
            productList = ref
                .watch(productsByKeywordProvider.notifier)
                .bestSellerProducts!;
          }

          ref.listen(productsByKeywordScrollProvider, (_, state) {
            if (state is ScrollReachedBottomState) {
              print('Keyword scroll reached bottom');
              if (widget.isNewCollectionProducts!) {
                ref
                    .read(productsByKeywordProvider.notifier)
                    .fetchMoreNewArrivalProdcuts();
              } else {
                ref
                    .read(productsByKeywordProvider.notifier)
                    .fetchMoreBestSellerProducts();
              }
            }
          });
        } else {
          state = ref.watch(productsByCategoryScrollProvider);

          productList = ref
              .watch(productsByCategoryProvider.notifier)
              .productsByCategory!;

          _scrollController =
              ref.read(productsByCategoryScrollProvider.notifier).controller;

          ref.listen(productsByCategoryScrollProvider, (_, state) {
            if (state is ScrollReachedBottomState) {
              print('Category scroll reached bottom');
              ref
                  .read(productsByCategoryProvider.notifier)
                  .fetchMoreProductsByCategory(widget.categoryId!);
            }
          });
        }
        final productsState = ref.watch(productsByKeywordProvider);
        final productsByCategoryState = ref.watch(productsByCategoryProvider);

        return Scaffold(
          backgroundColor: KColor.grey100,
          appBar: KAppBar(
            color: KColor.grey100!,
            leadingicon: Icons.arrow_back,
            suffixIconRequired: true,
            
            leadiconpress: () {
              Navigator.pop(context);
            },
            sufixicon: Icons.filter_alt_rounded,
            sufixiconpress: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute<void>(
                      builder: (BuildContext context) => const FilterPage()));
            },
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              if (!widget.fromCategoriesPage!) {
                if (widget.isNewCollectionProducts!) {
                  ref
                      .watch(productsByKeywordProvider.notifier)
                      .fetchNewArrivalProducts();
                } else {
                  ref
                      .watch(productsByKeywordProvider.notifier)
                      .fetchBestSellerProducts();
                }
              } else {
                ref
                    .watch(productsByCategoryProvider.notifier)
                    .fetchProductsByCategory(widget.categoryId!);
              }
            },
            backgroundColor: KColor.white,
            color: KColor.progressBlue,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                    child: Text(
                      widget.title,
                      style: KTextStyle.headline4
                          .copyWith(color: KColor.bodyTitle),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 25),
                    child: ((!widget.fromCategoriesPage! &&
                                productsState
                                    is ProductsByKeywordLoadingState) ||
                            (widget.fromCategoriesPage! &&
                                productsByCategoryState
                                    is ProductsByCategoryLoadingState))
                        ? Shimmer.fromColors(
                            child: Wrap(
                              spacing: 13,
                              key: _contentKey,
                              children: [
                                ...List.generate(10, (index) {
                                  return ShimmerProductCard(
                                    isGridView: true,
                                  );
                                })
                              ],
                            ),
                            baseColor: KColor.appBackground,
                            highlightColor: KColor.white)
                        : (productList.isEmpty)
                            ? NoProductFound()
                            : Wrap(spacing: 13, key: _contentKey, children: [
                                ...List.generate(
                                  productList.length,
                                  (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: AllProduct(
                                        product: productList[index],
                                        imagepaths:
                                            productList[index].thumbnail!,
                                        price:
                                            productList[index].price.toString(),
                                        text: productList[index].name!,
                                        newPrice: productList[index]
                                            .newPrice
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              ]),
                  ),
                  if (state is ScrollReachedBottomState)
                    Center(child: KLoadingIndicator()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
