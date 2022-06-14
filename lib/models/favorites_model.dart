import 'package:saxonmarket/models/product_model.dart';

class FavoritesModel {
  FavoritesModel({
    this.data,
  });

  List<Datum>? data;

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from((data == null ? [] : data!).map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.customerId,
    this.productId,
    this.product,
  });

  int? id;
  int? customerId;
  int? productId;
  ProductModel? product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        customerId: json["customerId"],
        productId: json["productId"],
        product: ProductModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customerId": customerId,
        "productId": productId,
        "product": product!.toJson(),
      };
}
