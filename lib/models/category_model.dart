class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.image,
    this.level,
    this.parentId,
    this.children,
  });

  int? id;
  String? name;
  String? image;
  String? level;
  int? parentId;
  List<CategoryModel>? children;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        level: json["level"],
        parentId: json["parentId"],
        children: List<CategoryModel>.from((json["children"] == null ? [] : json["children"]).map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "level": level,
        "parentId": parentId,
        "children": List<dynamic>.from((children == null ? [] : children!).map((x) => x.toJson())),
      };
}
