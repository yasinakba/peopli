/// id : 55
/// name : "vegas"
/// country : "united state "
/// createdAt : "2025-03-02T16:40:14"

class CityEntity {
  CityEntity({
      num? id, 
      String? name, 
      String? country, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _country = country;
    _createdAt = createdAt;
}

  CityEntity.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _country = json['country'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  String? _name;
  String? _country;
  String? _createdAt;
CityEntity copyWith({  num? id,
  String? name,
  String? country,
  String? createdAt,
}) => CityEntity(  id: id ?? _id,
  name: name ?? _name,
  country: country ?? _country,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get country => _country;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country'] = _country;
    map['createdAt'] = _createdAt;
    return map;
  }

}