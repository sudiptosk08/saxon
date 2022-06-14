class ProductDetailsModel {
  ProductDetailsModel({
    this.id,
    this.name,
    this.brand,
    this.thumbnail,
    this.description,
    this.categories,
    this.longDescription,
    this.images,
    this.active,
    this.weight,
    this.price,
    this.categoryId,
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.shop,
    this.features,
    this.options,
    this.newPrice,
    this.discountPrice,
    this.saving,
    this.reviews,
    this.questions,
    this.rating,
  });

  int? id;
  String? name;
  String? brand;
  String? thumbnail;
  String? description;
  String? categories;
  String? longDescription;
  List<Image>? images;
  bool? active;
  dynamic weight;
  int? price;
  int? categoryId;
  int? shopId;
  dynamic createdAt;
  dynamic updatedAt;
  Category? category;
  Shop? shop;
  List<Feature>? features;
  List<Option>? options;
  int? newPrice;
  String? discountPrice;
  String? saving;
  Reviews? reviews;
  int? questions;
  int? rating;

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        thumbnail: json["thumbnail"],
        description: json["description"],
        categories: json["categories"],
        longDescription: json["long_description"],
        images: List<Image>.from((json["images"] == null ? [] : json["images"]).map((x) => Image.fromJson(x))),
        active: json["active"],
        weight: json["weight"],
        price: json["price"],
        categoryId: json["categoryId"],
        shopId: json["shopId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
        features: List<Feature>.from((json["features"] == null ? [] : json["features"]).map((x) => Feature.fromJson(x))),
        options: List<Option>.from((json["options"] == null ? [] : json["options"]).map((x) => Option.fromJson(x))),
        newPrice: json["newPrice"],
        discountPrice: json["discountPrice"],
        saving: json["saving"],
        reviews: json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]),
        questions: json["questions"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "thumbnail": thumbnail,
        "description": description,
        "categories": categories,
        "long_description": longDescription,
        "images": List<dynamic>.from((images == null ? [] : images!).map((x) => x.toJson())),
        "active": active,
        "weight": weight,
        "price": price,
        "categoryId": categoryId,
        "shopId": shopId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "category": category == null ? null : category!.toJson(),
        "shop": shop == null ? null : shop!.toJson(),
        "features": List<dynamic>.from((features == null ? [] : features!).map((x) => x.toJson())),
        "options": List<dynamic>.from((options == null ? [] : options!).map((x) => x.toJson())),
        "newPrice": newPrice,
        "discountPrice": discountPrice,
        "saving": saving,
        "reviews": reviews == null ? null : reviews!.toJson(),
        "questions": questions,
        "rating": rating,
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.serial,
    this.level,
    this.parentId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? image;
  dynamic serial;
  String? level;
  int? parentId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        serial: json["serial"],
        level: json["level"],
        parentId: json["parentId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "serial": serial,
        "level": level,
        "parentId": parentId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Feature {
  Feature({
    this.id,
    this.body,
    this.productId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? body;
  int? productId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        body: json["body"],
        productId: json["productId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "productId": productId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Image {
  Image({
    this.thumbnail,
    this.url,
  });

  String? thumbnail;
  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        thumbnail: json["thumbnail"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "url": url,
      };
}

class Option {
  Option({
    this.id,
    this.name,
    this.type,
    this.required,
    this.rfields,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.optionvalues,
  });

  int? id;
  String? name;
  String? type;
  bool? required;
  int? rfields;
  int? productId;
  dynamic createdAt;
  dynamic updatedAt;
  List<Optionvalue>? optionvalues;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        required: json["required"],
        rfields: json["rfields"],
        productId: json["productId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        optionvalues: List<Optionvalue>.from((json["optionvalues"] == null ? [] : json["optionvalues"]).map((x) => Optionvalue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "required": required,
        "rfields": rfields,
        "productId": productId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "optionvalues": List<dynamic>.from((optionvalues == null ? [] : optionvalues!).map((x) => x.toJson())),
      };
}

class Optionvalue {
  Optionvalue({
    this.id,
    this.value,
    this.price,
    this.optionId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? value;
  int? price;
  int? optionId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Optionvalue.fromJson(Map<String, dynamic> json) => Optionvalue(
        id: json["id"],
        value: json["value"],
        price: json["price"],
        optionId: json["optionId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "price": price,
        "optionId": optionId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Reviews {
  Reviews({
    this.count,
    this.data,
  });

  int? count;
  List<Datum>? data;

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        count: json["count"],
        data: List<Datum>.from((json["data"] == null ? [] : json["data"]).map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "data": List<dynamic>.from((data == null ? [] : data!).map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.body,
    this.rating,
    this.productId,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.reviewer,
  });

  int? id;
  String? body;
  int? rating;
  int? productId;
  int? customerId;
  dynamic createdAt;
  dynamic updatedAt;
  Reviewer? reviewer;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        body: json["body"],
        rating: json["rating"],
        productId: json["productId"],
        customerId: json["customerId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        reviewer: json["reviewer"] == null ? null : Reviewer.fromJson(json["reviewer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "rating": rating,
        "productId": productId,
        "customerId": customerId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "reviewer": reviewer == null ? null : reviewer!.toJson(),
      };
}

class Reviewer {
  Reviewer({
    this.name,
    this.email,
    this.avatarUrl,
  });

  String? name;
  String? email;
  dynamic avatarUrl;

  factory Reviewer.fromJson(Map<String, dynamic> json) => Reviewer(
        name: json["name"],
        email: json["email"],
        avatarUrl: json["avatarUrl"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "avatarUrl": avatarUrl,
      };
}

class Shop {
  Shop({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.logo,
    this.banner,
    this.commission,
    this.active,
    this.isMarketplace,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? country;
  String? postcode;
  String? logo;
  String? banner;
  dynamic commission;
  bool? active;
  bool? isMarketplace;
  dynamic createdAt;
  dynamic updatedAt;

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postcode: json["postcode"],
        logo: json["logo"],
        banner: json["banner"],
        commission: json["commission"],
        active: json["active"],
        isMarketplace: json["isMarketplace"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "logo": logo,
        "banner": banner,
        "commission": commission,
        "active": active,
        "isMarketplace": isMarketplace,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
