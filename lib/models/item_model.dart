import 'package:saxonmarket/constants/asset_path.dart';

class ItemModel {
  String? name;
  String? category;
  String? price;
  String? priceBeforeDiscount;
  String? image;
  ItemModel({
    this.name,
    this.category,
    this.price,
    this.priceBeforeDiscount,
    this.image,
  });
}

List<ItemModel> itemLists = [
  ItemModel(
    name: "Men's Leather",
    category: "Bag",
    price: "300",
    priceBeforeDiscount: "320",
    image: AssetPath.backPack,
  ),
  ItemModel(
    name: "Men's Leather",
    category: "Bag",
    price: "300",
    priceBeforeDiscount: "320",
    image: AssetPath.backPack,
  ),
  ItemModel(
    name: "Men's Leather",
    category: "Bag",
    price: "300",
    priceBeforeDiscount: "320",
    image: AssetPath.backPack,
  ),
  ItemModel(
    name: "Men's Leather",
    category: "Bag",
    price: "300",
    priceBeforeDiscount: "320",
    image: AssetPath.backPack,
  ),
  ItemModel(
    name: "Men's Leather",
    category: "Bag",
    price: "300",
    priceBeforeDiscount: "320",
    image: AssetPath.backPack,
  ),
  ItemModel(
    name: "Men's Leather",
    category: "Bag",
    price: "300",
    priceBeforeDiscount: "320",
    image: AssetPath.backPack,
  ),
];
