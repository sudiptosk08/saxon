import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/constants/asset_path.dart';
import 'package:saxonmarket/controller/catergory/category_controller.dart';
import 'package:saxonmarket/controller/catergory/state/category_state.dart';
import 'package:saxonmarket/controller/products/products_by_category.dart';
import 'package:saxonmarket/controller/products/state/products_by_category_state.dart';
import 'package:saxonmarket/models/category_model.dart';
import 'package:saxonmarket/views/global_components/k_cart_component.dart';
import 'package:saxonmarket/views/global_components/loading_indicators/k_loading_indicator.dart';
import 'package:saxonmarket/views/screens/products/products_list_screen.dart';
import 'package:saxonmarket/views/styles/b_style.dart';

class CategoriesScreen extends StatefulWidget {
  final int index;
  const CategoriesScreen({Key? key, required this.index}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesScreen> {
  // List<String> categoryList = ['All', 'Women', 'Men', 'Kids'];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (builder, ref, _) {
      final categoriesState = ref.watch(categoryProvider);
      final categories = ref.watch(categoryProvider.notifier).categoryModel;
      return Scaffold(
        backgroundColor: KColor.grey100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15.0, right: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Builder(builder: (context) {
                          return IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: KColor.appBarTitle,
                            ),
                            iconSize: 25,
                          );
                        }),
                      ),
                      KCartComponent(),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Categories',
                    style:
                        KTextStyle.headline4.copyWith(color: KColor.bodyTitle),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, bottom: 20),
                    child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      children: categories![selectedIndex].children!.map((e) {
                        return categoryCard(e);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget categoryCard(CategoryModel category) {
    return Consumer(
      builder: (builder, ref, _) {
        final productsByCategoryState = ref.watch(productsByCategoryProvider);

        return GestureDetector(
          onTap: () {
            if (!(productsByCategoryState is ProductsByCategoryLoadingState)) {
              ref
                  .watch(productsByCategoryProvider.notifier)
                  .fetchProductsByCategory(category.id!);
            }
            Navigator.push(
                context,
                (CupertinoPageRoute(
                    builder: (context) => ProductsListScreen(
                          title: category.name.toString(),
                          categoryId: category.id,
                          fromCategoriesPage: true,
                        ))));
          },
          child: Container(
            height: KSize.getHeight(context, 250),
            width: KSize.getWidth(context, 343),
            color: KColor.grey100,
            padding: const EdgeInsets.only(bottom: 20),
            child: Stack(children: [
              Positioned(
                bottom: KSize.getHeight(context, 5),
                child: Padding(
                  padding: EdgeInsets.only(right: KSize.getWidth(context, 10)),
                  child: Stack(
                    children: [
                      Container(
                        height: KSize.getHeight(context, 103),
                        width: KSize.getWidth(context, 343),
                        decoration: BoxDecoration(
                            color: KColor.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: KColor.black.withOpacity(0.2),
                                blurRadius: 25,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: KSize.getWidth(context, 140),
                            top: KSize.getHeight(context, 20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category.name.toString(),
                                style: KTextStyle.bodyText1.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: KColor.drawerItem,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Text(
                              //   "2000 items",
                              //   style: KTextStyle.bodyText1.copyWith(
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.w400,
                              //     color: KColor.searchBarTitle,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            color: KColor.primary,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: KColor.secondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 5,
                bottom: 10,
                child: Container(
                  height: KSize.getHeight(context, 120),
                  width: KSize.getWidth(context, 112),
                  decoration: BoxDecoration(
                      color: KColor.containerBackground,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(AssetPath.placeholder),
                        fit: BoxFit.cover,
                      )),
                  // child: KImageView(
                  //   imagepaths: 'https://testapi.saxonmarket.com' +
                  //       category.image.toString(),
                  // ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
