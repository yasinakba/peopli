
class JobEntity {
  JobEntity({
      num? id, 
      String? name, 
      String? icon, 
      String? createdAt,}){
    _id = id;
    _name = name;
    _icon = icon;
    _createdAt = createdAt;
}

  JobEntity.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _icon = json['icon'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  String? _name;
  String? _icon;
  String? _createdAt;
  JobEntity copyWith({  num? id,
  String? name,
  String? icon,
  String? createdAt,
}) => JobEntity(  id: id ?? _id,
  name: name ?? _name,
  icon: icon ?? _icon,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['icon'] = _icon;
    map['createdAt'] = _createdAt;
    return map;
  }

}