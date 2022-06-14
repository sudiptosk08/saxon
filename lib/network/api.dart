import 'package:saxonmarket/services/app_mode.dart';

class API {
  static const LIVE = "https://api2.saxonmarket.com/"; // Live Production API URL
  static const TEST = "https://testapi.saxonmarket.com/"; // Live Staging API URL
  static const BASE = AppMode.PRODUCTION_MODE ? LIVE : TEST;

  /// Authentication
  static const login = 'login';

  static const register = 'register';
  static const verifyAccount = 'verify';
  static const forgotPassword = 'forgot-password';
  static const verifyPasswordReset = 'check-password-token';
  static const resetPassword = 'reset-password';
  static const getUser = 'profile'; // GET Route
  static const updateProfile = 'profile'; // POST Route
  static const changePassword = 'change-password';
  static const logout = 'logout';

  /// Location
  static const location = 'locations';

  /// Order
  static checkPromoCode({promoCode = '', userId}) => 'promos/check?code=$promoCode&userId=$userId';
  static const submitOrder = 'payment';
  static getOrders({orderId}) => 'my_orders/$orderId'; // To get single order details pass orderId

  /// Products
  static getProducts({keyword = '', limit = 15, str = '', pageNumber = '', categoryId = ''}) =>
      'products?keyword=$keyword&q=$str&categoryId=$categoryId&limit=$limit&page=$pageNumber'; // get product by keyword/category id/search
  static getProductDetails(productId) => 'products/$productId';
  static getCategories({isTree = false}) => 'categories?tree=$isTree';
  static const addProductToFavorites = 'mylist/add';
  static removeProductFromFavorites(productId) => 'mylist/remove/$productId';
  static const addProductReview = 'review';
  static const getFavoriteProducts = 'mylist';
}
