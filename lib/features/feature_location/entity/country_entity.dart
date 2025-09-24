/// id : 209
/// name : "united state "
/// citiesCount : 1
/// createdAt : "2025-03-02T11:29:54"

class CountryEntity {
  CountryEntity({
      num? id, 
      String? name, 
      num? citiesCount, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _citiesCount = citiesCount;
    _createdAt = createdAt;
}

  CountryEntity.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _citiesCount = json['citiesCount'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  String? _name;
  num? _citiesCount;
  String? _createdAt;
CountryEntity copyWith({  num? id,
  String? name,
  num? citiesCount,
  String? createdAt,
}) => CountryEntity(  id: id ?? _id,
  name: name ?? _name,
  citiesCount: citiesCount ?? _citiesCount,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get name => _name;
  num? get citiesCount => _citiesCount;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['citiesCount'] = _citiesCount;
    map['createdAt'] = _createdAt;
    return map;
  }

}