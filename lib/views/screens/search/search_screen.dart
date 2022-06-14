import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/pagination/products/products_by_search_scroll_provider.dart';
import 'package:saxonmarket/controller/pagination/scroll_state.dart';
import 'package:saxonmarket/controller/products/products_by_search_controller.dart';
import 'package:saxonmarket/controller/products/state/products_by_search_state.dart';
import 'package:saxonmarket/services/debouncer.dart';
import 'package:saxonmarket/views/global_components/all_product.dart';
import 'package:saxonmarket/views/global_components/k_cart_component.dart';
import 'package:saxonmarket/views/global_components/k_no_product_found.dart';
import 'package:saxonmarket/views/global_components/k_shimmer_card.dart';
import 'package:saxonmarket/views/global_components/k_text_field.dart';
import 'package:saxonmarket/views/global_components/loading_indicators/k_loading_indicator.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer();
 
  String keyword = '';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (builder, ref, _) {
        final productSearchState = ref.watch(productsBySearchProvider);
        final productsBySearchKeyword = ref.watch(productsBySearchProvider.notifier).productsBySearch;
        final productsBySearchScrollState = ref.watch(productsBySearchScrollProvider);

        ref.listen(productsBySearchScrollProvider, (_, state) {
          if (state is ScrollReachedBottomState) {
            print('reached bottom');
            ref.read(productsBySearchProvider.notifier).fetchMoreProductsBySearch(searchController.text);
          }
        });

        return Scaffold(
          backgroundColor: KColor.grey100,
          appBar: AppBar(
              elevation: 0.3,
              backgroundColor: KColor.primary,
              toolbarHeight: 130,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Column(children: [
                const SizedBox(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Builder(builder: (context) {
                        return IconButton(
                          icon: Icon(Icons.arrow_back),
                          iconSize: 25,
                          color: KColor.white,
                          onPressed: () => Navigator.of(context).pop(),
                        );
                      }),
                    ),
                    Text(
                      'Saxon',
                      style: KTextStyle.headline5.copyWith(color: KColor.white),
                    ),
                    KCartComponent(isHomePage: true),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                    width: MediaQuery.of(context).size.width * 0.88,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: KColor.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: KColor.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: KTextField(
                      hintText: "Search Store",
                      hintColor: KColor.searchBarTitle,
                      //controller: searchController,
                      callBack: true,
                      callBackFunction: (str) {
                        if (str.isNotEmpty) {
                          debouncer.run(() {
                            setState(() {
                              keyword = str;
                            });

                            ref.watch(productsBySearchProvider.notifier).fetchProductsBySearch(str);
                          });
                        }
                      },
                      inputBorder: InputBorder.none,
                      prefixIcon: const Icon(Icons.search, color: KColor.searchBarTitle, size: 21),
                      hasPrefixIcon: true,
                      topMargin: 2,
                      autofocus: true,
                    )),
              ])),
          body: SingleChildScrollView(
            controller: ref.read(productsBySearchScrollProvider.notifier).controller,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  'Search results: ',
                  style: KTextStyle.headline4.copyWith(fontSize: 20, color: KColor.bodyTitle, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: (productSearchState is ProductsBySearchLoadingState)
                    ? Shimmer.fromColors(
                        child: Wrap(
                          spacing: 13,
                          children: [
                            ...List.generate(10, (index) {
                              return ShimmerProductCard(isGridView: true);
                            })
                          ],
                        ),
                        baseColor: KColor.appBackground,
                        highlightColor: KColor.white)
                    : (productsBySearchKeyword!.isEmpty)
                        ? NoProductFound()
                        : Wrap(spacing: 13, children: [
                            ...List.generate(
                              productsBySearchKeyword.length,
                              (index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: AllProduct(
                                      product: productsBySearchKeyword[index],
                                      imagepaths: productsBySearchKeyword[index].thumbnail!,
                                      price: productsBySearchKeyword[index].price.toString(),
                                      text: productsBySearchKeyword[index].name!,
                                      newPrice: productsBySearchKeyword[index].discountPrice.toString()),
                                );
                              },
                            ),
                          ]),
              ),
              if (productsBySearchScrollState is ScrollReachedBottomState) Center(child: KLoadingIndicator()),
            ]),
          ),
        );
      },
    );
  }

 
}
