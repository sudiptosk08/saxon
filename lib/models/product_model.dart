class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.categoryId,
    this.categories,
    this.thumbnail,
    this.price,
    this.brand,
    this.shopId,
    this.newPrice,
    this.discountPrice,
    this.reviews,
    this.rating,
  });

  int? id;
  String? name;
  int? categoryId;
  String? categories;
  String? thumbnail;
  int? price;
  String? brand;
  int? shopId;
  int? newPrice;
  int? discountPrice;
  int? reviews;
  int? rating;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        categories: json["categories"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        brand: json["brand"],
        shopId: json["shopId"],
        newPrice: json["newPrice"],
        discountPrice: json["discountPrice"],
        reviews: json["reviews"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "categories": categories,
        "thumbnail": thumbnail,
        "price": price,
        "brand": brand,
        "shopId": shopId,
        "newPrice": newPrice,
        "discountPrice": discountPrice,
        "reviews": reviews,
        "rating": rating,
      };
}
