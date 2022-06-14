class LocationModel {
  LocationModel({
    this.id,
    this.name,
    this.districts,
  });

  int? id;
  String? name;
  List<District>? districts;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        name: json["name"],
        districts: List<District>.from((json["districts"] == null ? [] : json["districts"]).map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "districts": List<dynamic>.from((districts == null ? [] : districts!).map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.name,
    this.divisionId,
    this.upozillas,
  });

  int? id;
  String? name;
  int? divisionId;
  List<Upozilla>? upozillas;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        name: json["name"],
        divisionId: json["divisionId"],
        upozillas: List<Upozilla>.from((json["upozillas"] == null ? [] : json["upozillas"]).map((x) => Upozilla.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "divisionId": divisionId,
        "upozillas": List<dynamic>.from((upozillas == null ? [] : upozillas!).map((x) => x.toJson())),
      };
}

class Upozilla {
  Upozilla({
    this.id,
    this.name,
    this.districtId,
    this.areas,
  });

  int? id;
  String? name;
  int? districtId;
  List<Area>? areas;

  factory Upozilla.fromJson(Map<String, dynamic> json) => Upozilla(
        id: json["id"],
        name: json["name"],
        districtId: json["districtId"],
        areas: List<Area>.from((json["areas"] == null ? null : json["areas"]).map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "districtId": districtId,
        "areas": List<dynamic>.from((areas == null ? [] : areas!).map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.inMetro,
    this.upozillaId,
  });

  int? id;
  String? name;
  bool? inMetro;
  int? upozillaId;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        inMetro: json["inMetro"],
        upozillaId: json["upozillaId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "inMetro": inMetro,
        "upozillaId": upozillaId,
      };
}
