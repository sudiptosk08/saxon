import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:saxonmarket/constants/shared_preference_constant.dart';
import 'package:saxonmarket/controller/auth/user_controller.dart';
import 'package:saxonmarket/controller/catergory/category_controller.dart';
import 'package:saxonmarket/controller/products/products_by_keyword_controller.dart';

final initDataProvider = StateNotifierProvider<InitDataController, Type>(
  (ref) => InitDataController(ref: ref),
);

class InitDataController extends StateNotifier<Type> {
  final Ref ref;
  InitDataController({required this.ref}) : super(Type);

  Future fetchData() async {
    bool _isLoggedIn = getBoolAsync(LOGGED_IN, defaultValue: false);
    try {
      if (_isLoggedIn) {
        ref.read(userProvider.notifier).getAuthUser();
      }

      ref.watch(productsByKeywordProvider.notifier).fetchNewArrivalProducts();
      ref.watch(productsByKeywordProvider.notifier).fetchBestSellerProducts();
      ref.watch(categoryProvider.notifier).fetchCategories();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }
}
