/// id : 6
/// userId : 434
/// user : "YasinAK"
/// faceId : 52
/// face : "Anglina july"
/// title : null
/// text : "test"
/// type : "test"
/// lat : 0
/// lng : 0
/// media : "/data/user/0/com.example.peopli/cache/6a4c9fa4-5578-4336-803f-d3eecbfba856/IMG_20250831_173002.jpg"
/// likesCount : 0
/// isLiked : false
/// commentsCount : 0
/// date : "2025-08-31T17:00:45"
/// createdAt : "2025-08-31T17:00:45"

class MemoryEntity {
  MemoryEntity({
      num? id, 
      num? userId, 
      String? user, 
      num? faceId, 
      String? face, 
      dynamic title, 
      String? text, 
      String? type, 
      num? lat, 
      num? lng, 
      String? media, 
      int? likesCount,
      bool? isLiked, 
      num? commentsCount, 
      String? date, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _user = user;
    _faceId = faceId;
    _face = face;
    _title = title;
    _text = text;
    _type = type;
    _lat = lat;
    _lng = lng;
    _media = media;
    _likesCount = likesCount;
    _isLiked = isLiked;
    _commentsCount = commentsCount;
    _date = date;
    _createdAt = createdAt;
}

  MemoryEntity.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['userId'];
    _user = json['user'];
    _faceId = json['faceId'];
    _face = json['face'];
    _title = json['title'];
    _text = json['text'];
    _type = json['type'];
    _lat = json['lat'];
    _lng = json['lng'];
    _media = json['media'];
    _likesCount = json['likesCount'];
    _isLiked = json['isLiked'];
    _commentsCount = json['commentsCount'];
    _date = json['date'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  num? _userId;
  String? _user;
  num? _faceId;
  String? _face;
  dynamic _title;
  String? _text;
  String? _type;
  num? _lat;
  num? _lng;
  String? _media;
  int? _likesCount;
  bool? _isLiked;
  num? _commentsCount;
  String? _date;
  String? _createdAt;
MemoryEntity copyWith({  num? id,
  num? userId,
  String? user,
  num? faceId,
  String? face,
  dynamic title,
  String? text,
  String? type,
  num? lat,
  num? lng,
  String? media,
  int? likesCount,
  bool? isLiked,
  num? commentsCount,
  String? date,
  String? createdAt,
}) => MemoryEntity(  id: id ?? _id,
  userId: userId ?? _userId,
  user: user ?? _user,
  faceId: faceId ?? _faceId,
  face: face ?? _face,
  title: title ?? _title,
  text: text ?? _text,
  type: type ?? _type,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  media: media ?? _media,
  likesCount: likesCount ?? _likesCount,
  isLiked: isLiked ?? _isLiked,
  commentsCount: commentsCount ?? _commentsCount,
  date: date ?? _date,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get user => _user;
  num? get faceId => _faceId;
  String? get face => _face;
  dynamic get title => _title;
  String? get text => _text;
  String? get type => _type;
  num? get lat => _lat;
  num? get lng => _lng;
  String? get media => _media;
  int? get likesCount => _likesCount;
  bool? get isLiked => _isLiked;
  num? get commentsCount => _commentsCount;
  String? get date => _date;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['user'] = _user;
    map['faceId'] = _faceId;
    map['face'] = _face;
    map['title'] = _title;
    map['text'] = _text;
    map['type'] = _type;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['media'] = _media;
    map['likesCount'] = _likesCount;
    map['isLiked'] = _isLiked;
    map['commentsCount'] = _commentsCount;
    map['date'] = _date;
    map['createdAt'] = _createdAt;
    return map;
  }

}