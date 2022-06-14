import 'package:saxonmarket/models/product_model.dart';

class ProductListModel {
  ProductListModel({
    this.total,
    this.rowPerPage,
    this.totalPage,
    this.currentPage,
    this.result,
  });

  int? total;
  int? rowPerPage;
  int? totalPage;
  int? currentPage;
  List<ProductModel>? result;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        total: json["total"],
        rowPerPage: json["row_per_page"],
        totalPage: json["total_page"],
        currentPage: json["current_page"],
        result: List<ProductModel>.from((json["result"] == null ? [] : json["result"]).map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "row_per_page": rowPerPage,
        "total_page": totalPage,
        "current_page": currentPage,
        "result": List<ProductModel>.from((result == null ? [] : result!).map((x) => x.toJson())),
      };
}
