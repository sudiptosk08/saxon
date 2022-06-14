import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/controller/catergory/category_controller.dart';
import 'package:saxonmarket/controller/catergory/state/category_state.dart';
import 'package:saxonmarket/controller/products/products_by_keyword_controller.dart';
import 'package:saxonmarket/controller/products/state/products_by_keyword_state.dart';
import 'package:saxonmarket/services/navigation_service.dart';
import 'package:saxonmarket/views/global_components/k_cart_component.dart';
import 'package:saxonmarket/views/global_components/k_shimmer_card.dart';
import 'package:saxonmarket/views/global_components/k_text_field.dart';
import 'package:saxonmarket/views/global_components/loading_indicators/k_loading_indicator.dart';
import 'package:saxonmarket/views/global_components/product_card.dart';
import 'package:saxonmarket/views/screens/categories/categories_screen.dart';
import 'package:saxonmarket/views/screens/drawer/drawer_widget.dart';
import 'package:saxonmarket/views/screens/products/products_list_screen.dart';
import 'package:saxonmarket/views/screens/search/search_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (builder, ref, _) {
      final productsState = ref.watch(productsByKeywordProvider);
      final productsNewArrival =
          ref.watch(productsByKeywordProvider.notifier).newArrivalProducts;
      final productsBestSeller =
          ref.watch(productsByKeywordProvider.notifier).bestSellerProducts;
      final categoriesState = ref.watch(categoryProvider);
      final categories = ref.watch(categoryProvider.notifier).categoryModel;

      return Scaffold(
          backgroundColor: KColor.grey100,
          drawer: const DrawerWidget(),
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
                          icon: Icon(Icons.menu_sharp),
                          iconSize: 25,
                          color: KColor.white,
                          onPressed: () => Scaffold.of(context).openDrawer());
                    }),
                  ),
                  Text(
                    'Saxon',
                    style: KTextStyle.headline5.copyWith(color: KColor.white),
                  ),
                  KCartComponent(
                    isHomePage: true,
                  ),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: KColor.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: KTextField(
                    hintText: "Search Store",
                    hintColor: KColor.searchBarTitle,
                    isReadOnly: true,
                    prefixIcon: const Icon(Icons.search,
                        color: KColor.searchBarTitle, size: 21),
                    hasPrefixIcon: true,
                    topMargin: 2,
                    inputBorder: InputBorder.none,
                    onTap: () {
                      Navigator.push(context, FadeRoute(page: SearchScreen()));
                    },
                  )),
            ]),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.watch(categoryProvider.notifier).fetchCategories();
              ref
                  .watch(productsByKeywordProvider.notifier)
                  .fetchNewArrivalProducts();
              ref
                  .watch(productsByKeywordProvider.notifier)
                  .fetchBestSellerProducts();
            },
            backgroundColor: KColor.white,
            color: KColor.progressBlue,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: KSize.getWidth(context, 343),
                    height: KSize.getHeight(context, 155),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                          image: AssetImage(AssetPath.banner),
                          fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                "SALE 30%",
                                style: KTextStyle.headline6
                                    .copyWith(color: KColor.primary),
                              ),
                              Text(
                                "FOR EVERY THING",
                                style: KTextStyle.headline6
                                    .copyWith(color: KColor.bodyTitle),
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "Shop Now",
                                  style: KTextStyle.button.copyWith(
                                    color: KColor.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  categoriesState is CategoryLoadingState
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: KLoadingIndicator())
                      : Padding(
                          padding: const EdgeInsets.only(left: 20.0, top: 15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(
                                  categories!.length,
                                  (index) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        CategoriesScreen(
                                                          index: selectedIndex,
                                                        )));
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Text(categories[index].name!,
                                            style: selectedIndex == index
                                                ? KTextStyle.headline6.copyWith(
                                                    color: KColor.primary)
                                                : KTextStyle.headline6.copyWith(
                                                    color: KColor.accentColor)),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                  SizedBox(height: 15),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 15, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("New Collection",
                            style: KTextStyle.headline6.copyWith(
                                fontWeight: FontWeight.w600,
                                color: KColor.primary)),
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const ProductsListScreen(
                                        title: 'New Collection',
                                        isNewCollectionProducts: true,
                                      ))),
                          child: Container(
                            alignment: Alignment.center,
                            width: KSize.getWidth(context, 80),
                            height: 30,
                            child: Text(
                              "Show All",
                              style: KTextStyle.button.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: KColor.accentColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 12),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: (productsState is ProductsByKeywordLoadingState)
                            ? Shimmer.fromColors(
                                child: Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: ShimmerProductCard(),
                                      );
                                    })
                                  ],
                                ),
                                baseColor: KColor.appBackground,
                                highlightColor: KColor.white)
                            : Row(children: [
                                ...List.generate(
                                  productsNewArrival!.length,
                                  (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0,bottom: 10),
                                      child: ProductCard(
                                        product: productsNewArrival[index],
                                        imagepaths:
                                            // 'https://testapi.saxonmarket.com/' +
                                            '${productsNewArrival[index].thumbnail}',
                                        price:
                                            '${productsNewArrival[index].price}',
                                        text:
                                            '${productsNewArrival[index].name}',
                                        discountPrice:
                                            '${productsNewArrival[index].discountPrice}',
                                      ),
                                    );
                                  },
                                ),
                              ])),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, top: 15, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Selling",
                          style: KTextStyle.headline6.copyWith(
                              fontWeight: FontWeight.w600,
                              color: KColor.primary),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const ProductsListScreen(
                                          title: 'Best Selling',
                                          isNewCollectionProducts: false,
                                        )));
                          },
                          child: Container(
                            width: KSize.getWidth(context, 80),
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                              "Show All",
                              style: KTextStyle.button.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: KColor.accentColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: (productsState is ProductsByKeywordLoadingState)
                          ? Shimmer.fromColors(
                              child: Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: ShimmerProductCard(),
                                    );
                                  })
                                ],
                              ),
                              baseColor: KColor.appBackground,
                              highlightColor: KColor.white)
                          : Row(children: [
                              ...List.generate(
                                productsBestSeller!.length,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 20.0,bottom: 10),
                                    child: ProductCard(
                                      product: productsBestSeller[index],
                                      imagepaths:
                                          '${productsBestSeller[index].thumbnail}',
                                      price:
                                          '${productsBestSeller[index].price}',
                                      text: '${productsBestSeller[index].name}',
                                      discountPrice:
                                          '${productsBestSeller[index].discountPrice}',
                                    ),
                                  );
                                },
                              ),
                            ]),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ));
    });
  }
}
