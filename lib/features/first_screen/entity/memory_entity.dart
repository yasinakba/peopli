/// id : 35
/// userId : 443
/// user : "YasinAK"
/// userAvatar : "42_ebb8.jpg"
/// username : "YasinDeveloper"
/// userCityId : null
/// userCity : "vegas"
/// userEducationId : 0
/// userEducation : "Worker3333"
/// faceId : 85
/// face : "testD test"
/// faceHomeTownId : 0
/// faceHomeTown : "vegas"
/// faceEducationId : 0
/// faceEducation : "Worker3333"
/// faceJobId : 0
/// faceJob : "۲۲۲۲۲"
/// faceBirthdate : "2025-11-06"
/// faceGender : "male"
/// faceAvatar : "42_0b4a.jpg"
/// faceRating : 0
/// faceKnownFor : "test"
/// title : "0"
/// text : "tel;k;ljk"
/// type : "jkkkklkl"
/// lat : 0
/// lng : 0
/// media : "42_a75e.jpg"
/// likesCount : 0
/// isLiked : false
/// commentsCount : 0
/// date : "2025-11-07T00:00:00"
/// createdAt : "2025-11-07T10:34:52"

class MemoryEntity {
  MemoryEntity({
      num? id, 
      num? userId, 
      String? user, 
      String? userAvatar, 
      String? username, 
      dynamic userCityId, 
      String? userCity, 
      num? userEducationId, 
      String? userEducation, 
      num? faceId, 
      String? face, 
      num? faceHomeTownId, 
      String? faceHomeTown, 
      num? faceEducationId, 
      String? faceEducation, 
      num? faceJobId, 
      String? faceJob, 
      String? faceBirthdate, 
      String? faceGender, 
      String? faceAvatar, 
      num? faceRating, 
      String? faceKnownFor, 
      String? title, 
      String? text, 
      String? type, 
      num? lat, 
      num? lng, 
      String? media, 
      num? likesCount, 
      bool? isLiked, 
      num? commentsCount, 
      String? date, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _user = user;
    _userAvatar = userAvatar;
    _username = username;
    _userCityId = userCityId;
    _userCity = userCity;
    _userEducationId = userEducationId;
    _userEducation = userEducation;
    _faceId = faceId;
    _face = face;
    _faceHomeTownId = faceHomeTownId;
    _faceHomeTown = faceHomeTown;
    _faceEducationId = faceEducationId;
    _faceEducation = faceEducation;
    _faceJobId = faceJobId;
    _faceJob = faceJob;
    _faceBirthdate = faceBirthdate;
    _faceGender = faceGender;
    _faceAvatar = faceAvatar;
    _faceRating = faceRating;
    _faceKnownFor = faceKnownFor;
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
    _userAvatar = json['userAvatar'];
    _username = json['username'];
    _userCityId = json['userCityId'];
    _userCity = json['userCity'];
    _userEducationId = json['userEducationId'];
    _userEducation = json['userEducation'];
    _faceId = json['faceId'];
    _face = json['face'];
    _faceHomeTownId = json['faceHomeTownId'];
    _faceHomeTown = json['faceHomeTown'];
    _faceEducationId = json['faceEducationId'];
    _faceEducation = json['faceEducation'];
    _faceJobId = json['faceJobId'];
    _faceJob = json['faceJob'];
    _faceBirthdate = json['faceBirthdate'];
    _faceGender = json['faceGender'];
    _faceAvatar = json['faceAvatar'];
    _faceRating = json['faceRating'];
    _faceKnownFor = json['faceKnownFor'];
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
  String? _userAvatar;
  String? _username;
  dynamic _userCityId;
  String? _userCity;
  num? _userEducationId;
  String? _userEducation;
  num? _faceId;
  String? _face;
  num? _faceHomeTownId;
  String? _faceHomeTown;
  num? _faceEducationId;
  String? _faceEducation;
  num? _faceJobId;
  String? _faceJob;
  String? _faceBirthdate;
  String? _faceGender;
  String? _faceAvatar;
  num? _faceRating;
  String? _faceKnownFor;
  String? _title;
  String? _text;
  String? _type;
  num? _lat;
  num? _lng;
  String? _media;
  num? _likesCount;
  bool? _isLiked;
  num? _commentsCount;
  String? _date;
  String? _createdAt;
MemoryEntity copyWith({  num? id,
  num? userId,
  String? user,
  String? userAvatar,
  String? username,
  dynamic userCityId,
  String? userCity,
  num? userEducationId,
  String? userEducation,
  num? faceId,
  String? face,
  num? faceHomeTownId,
  String? faceHomeTown,
  num? faceEducationId,
  String? faceEducation,
  num? faceJobId,
  String? faceJob,
  String? faceBirthdate,
  String? faceGender,
  String? faceAvatar,
  num? faceRating,
  String? faceKnownFor,
  String? title,
  String? text,
  String? type,
  num? lat,
  num? lng,
  String? media,
  num? likesCount,
  bool? isLiked,
  num? commentsCount,
  String? date,
  String? createdAt,
}) => MemoryEntity(  id: id ?? _id,
  userId: userId ?? _userId,
  user: user ?? _user,
  userAvatar: userAvatar ?? _userAvatar,
  username: username ?? _username,
  userCityId: userCityId ?? _userCityId,
  userCity: userCity ?? _userCity,
  userEducationId: userEducationId ?? _userEducationId,
  userEducation: userEducation ?? _userEducation,
  faceId: faceId ?? _faceId,
  face: face ?? _face,
  faceHomeTownId: faceHomeTownId ?? _faceHomeTownId,
  faceHomeTown: faceHomeTown ?? _faceHomeTown,
  faceEducationId: faceEducationId ?? _faceEducationId,
  faceEducation: faceEducation ?? _faceEducation,
  faceJobId: faceJobId ?? _faceJobId,
  faceJob: faceJob ?? _faceJob,
  faceBirthdate: faceBirthdate ?? _faceBirthdate,
  faceGender: faceGender ?? _faceGender,
  faceAvatar: faceAvatar ?? _faceAvatar,
  faceRating: faceRating ?? _faceRating,
  faceKnownFor: faceKnownFor ?? _faceKnownFor,
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
  String? get userAvatar => _userAvatar;
  String? get username => _username;
  dynamic get userCityId => _userCityId;
  String? get userCity => _userCity;
  num? get userEducationId => _userEducationId;
  String? get userEducation => _userEducation;
  num? get faceId => _faceId;
  String? get face => _face;
  num? get faceHomeTownId => _faceHomeTownId;
  String? get faceHomeTown => _faceHomeTown;
  num? get faceEducationId => _faceEducationId;
  String? get faceEducation => _faceEducation;
  num? get faceJobId => _faceJobId;
  String? get faceJob => _faceJob;
  String? get faceBirthdate => _faceBirthdate;
  String? get faceGender => _faceGender;
  String? get faceAvatar => _faceAvatar;
  num? get faceRating => _faceRating;
  String? get faceKnownFor => _faceKnownFor;
  String? get title => _title;
  String? get text => _text;
  String? get type => _type;
  num? get lat => _lat;
  num? get lng => _lng;
  String? get media => _media;
  num? get likesCount => _likesCount;
  bool? get isLiked => _isLiked;
  num? get commentsCount => _commentsCount;
  String? get date => _date;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userId'] = _userId;
    map['user'] = _user;
    map['userAvatar'] = _userAvatar;
    map['username'] = _username;
    map['userCityId'] = _userCityId;
    map['userCity'] = _userCity;
    map['userEducationId'] = _userEducationId;
    map['userEducation'] = _userEducation;
    map['faceId'] = _faceId;
    map['face'] = _face;
    map['faceHomeTownId'] = _faceHomeTownId;
    map['faceHomeTown'] = _faceHomeTown;
    map['faceEducationId'] = _faceEducationId;
    map['faceEducation'] = _faceEducation;
    map['faceJobId'] = _faceJobId;
    map['faceJob'] = _faceJob;
    map['faceBirthdate'] = _faceBirthdate;
    map['faceGender'] = _faceGender;
    map['faceAvatar'] = _faceAvatar;
    map['faceRating'] = _faceRating;
    map['faceKnownFor'] = _faceKnownFor;
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