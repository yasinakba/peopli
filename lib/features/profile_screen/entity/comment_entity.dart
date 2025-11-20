/// id : 8
/// memoryId : 2
/// faceId : 34
/// memoryPosterId : 432
/// memoryTitle : "test"
/// memoryType : "test"
/// memoryPoster : "test"
/// memoryPosterAvatar : "test"
/// faceName : "Yasin"
/// faceRating : 0
/// faceAvatar : "noavatar.png"
/// faceKnownFor : "sfa"
/// faceBirthdate : null
/// faceHometown : null
/// text : "test"
/// user : {"id":443,"displayName":"YasinAK","avatar":"42_ebb8.jpg"}
/// type : "test"
/// createdAt : "2025-11-07T10:33:57"

class MyCommentEntity {
  MyCommentEntity({
      num? id, 
      num? memoryId, 
      num? faceId, 
      num? memoryPosterId, 
      String? memoryTitle, 
      String? memoryType, 
      String? memoryPoster, 
      String? memoryPosterAvatar, 
      String? faceName, 
      num? faceRating, 
      String? faceAvatar, 
      String? faceKnownFor, 
      dynamic faceBirthdate, 
      dynamic faceHometown, 
      String? text, 
      User? user, 
      String? type, 
      String? createdAt,}){
    _id = id;
    _memoryId = memoryId;
    _faceId = faceId;
    _memoryPosterId = memoryPosterId;
    _memoryTitle = memoryTitle;
    _memoryType = memoryType;
    _memoryPoster = memoryPoster;
    _memoryPosterAvatar = memoryPosterAvatar;
    _faceName = faceName;
    _faceRating = faceRating;
    _faceAvatar = faceAvatar;
    _faceKnownFor = faceKnownFor;
    _faceBirthdate = faceBirthdate;
    _faceHometown = faceHometown;
    _text = text;
    _user = user;
    _type = type;
    _createdAt = createdAt;
}

  MyCommentEntity.fromJson(dynamic json) {
    _id = json['id'];
    _memoryId = json['memoryId'];
    _faceId = json['faceId'];
    _memoryPosterId = json['memoryPosterId'];
    _memoryTitle = json['memoryTitle'];
    _memoryType = json['memoryType'];
    _memoryPoster = json['memoryPoster'];
    _memoryPosterAvatar = json['memoryPosterAvatar'];
    _faceName = json['faceName'];
    _faceRating = json['faceRating'];
    _faceAvatar = json['faceAvatar'];
    _faceKnownFor = json['faceKnownFor'];
    _faceBirthdate = json['faceBirthdate'];
    _faceHometown = json['faceHometown'];
    _text = json['text'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _type = json['type'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  num? _memoryId;
  num? _faceId;
  num? _memoryPosterId;
  String? _memoryTitle;
  String? _memoryType;
  String? _memoryPoster;
  String? _memoryPosterAvatar;
  String? _faceName;
  num? _faceRating;
  String? _faceAvatar;
  String? _faceKnownFor;
  dynamic _faceBirthdate;
  dynamic _faceHometown;
  String? _text;
  User? _user;
  String? _type;
  String? _createdAt;
MyCommentEntity copyWith({  num? id,
  num? memoryId,
  num? faceId,
  num? memoryPosterId,
  String? memoryTitle,
  String? memoryType,
  String? memoryPoster,
  String? memoryPosterAvatar,
  String? faceName,
  num? faceRating,
  String? faceAvatar,
  String? faceKnownFor,
  dynamic faceBirthdate,
  dynamic faceHometown,
  String? text,
  User? user,
  String? type,
  String? createdAt,
}) => MyCommentEntity(  id: id ?? _id,
  memoryId: memoryId ?? _memoryId,
  faceId: faceId ?? _faceId,
  memoryPosterId: memoryPosterId ?? _memoryPosterId,
  memoryTitle: memoryTitle ?? _memoryTitle,
  memoryType: memoryType ?? _memoryType,
  memoryPoster: memoryPoster ?? _memoryPoster,
  memoryPosterAvatar: memoryPosterAvatar ?? _memoryPosterAvatar,
  faceName: faceName ?? _faceName,
  faceRating: faceRating ?? _faceRating,
  faceAvatar: faceAvatar ?? _faceAvatar,
  faceKnownFor: faceKnownFor ?? _faceKnownFor,
  faceBirthdate: faceBirthdate ?? _faceBirthdate,
  faceHometown: faceHometown ?? _faceHometown,
  text: text ?? _text,
  user: user ?? _user,
  type: type ?? _type,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  num? get memoryId => _memoryId;
  num? get faceId => _faceId;
  num? get memoryPosterId => _memoryPosterId;
  String? get memoryTitle => _memoryTitle;
  String? get memoryType => _memoryType;
  String? get memoryPoster => _memoryPoster;
  String? get memoryPosterAvatar => _memoryPosterAvatar;
  String? get faceName => _faceName;
  num? get faceRating => _faceRating;
  String? get faceAvatar => _faceAvatar;
  String? get faceKnownFor => _faceKnownFor;
  dynamic get faceBirthdate => _faceBirthdate;
  dynamic get faceHometown => _faceHometown;
  String? get text => _text;
  User? get user => _user;
  String? get type => _type;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['memoryId'] = _memoryId;
    map['faceId'] = _faceId;
    map['memoryPosterId'] = _memoryPosterId;
    map['memoryTitle'] = _memoryTitle;
    map['memoryType'] = _memoryType;
    map['memoryPoster'] = _memoryPoster;
    map['memoryPosterAvatar'] = _memoryPosterAvatar;
    map['faceName'] = _faceName;
    map['faceRating'] = _faceRating;
    map['faceAvatar'] = _faceAvatar;
    map['faceKnownFor'] = _faceKnownFor;
    map['faceBirthdate'] = _faceBirthdate;
    map['faceHometown'] = _faceHometown;
    map['text'] = _text;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['type'] = _type;
    map['createdAt'] = _createdAt;
    return map;
  }

}

/// id : 443
/// displayName : "YasinAK"
/// avatar : "42_ebb8.jpg"

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