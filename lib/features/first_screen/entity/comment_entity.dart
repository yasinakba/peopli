/// id : 2
/// text : "Hello yasin I wish succeed "
/// user : {"id":434,"displayName":"YasinAK","avatar":"noavatar.png"}
/// type : "neutral"
/// createdAt : "2025-08-25T14:33:04"

class CommentEntity {
  CommentEntity({
      num? id, 
      String? text, 
      User? user, 
      String? type, 
      String? createdAt,}){
    _id = id;
    _text = text;
    _user = user;
    _type = type;
    _createdAt = createdAt;
}

  CommentEntity.fromJson(dynamic json) {
    _id = json['id'];
    _text = json['text'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _type = json['type'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  String? _text;
  User? _user;
  String? _type;
  String? _createdAt;
CommentEntity copyWith({  num? id,
  String? text,
  User? user,
  String? type,
  String? createdAt,
}) => CommentEntity(  id: id ?? _id,
  text: text ?? _text,
  user: user ?? _user,
  type: type ?? _type,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  String? get text => _text;
  User? get user => _user;
  String? get type => _type;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['text'] = _text;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['type'] = _type;
    map['createdAt'] = _createdAt;
    return map;
  }

}

/// id : 434
/// displayName : "YasinAK"
/// avatar : "noavatar.png"

class User {
  User({
      num? id, 
      String? displayName, 
      String? avatar,}){
    _id = id;
    _displayName = displayName;
    _avatar = avatar;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _displayName = json['displayName'];
    _avatar = json['avatar'];
  }
  num? _id;
  String? _displayName;
  String? _avatar;
User copyWith({  num? id,
  String? displayName,
  String? avatar,
}) => User(  id: id ?? _id,
  displayName: displayName ?? _displayName,
  avatar: avatar ?? _avatar,
);
  num? get id => _id;
  String? get displayName => _displayName;
  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['displayName'] = _displayName;
    map['avatar'] = _avatar;
    return map;
  }

}