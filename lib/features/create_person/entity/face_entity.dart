/// id : 130
/// homeTownId : 53
/// homeTown : "hamedan"
/// jobId : 23
/// job : "ggggggggggg"
/// education : "Worker3333"
/// country : "iran"
/// name : "YasinDeveloper"
/// lastName : "YAsin"
/// knownFor : "known"
/// birthdate : "2025-11-26"
/// avatar : "41_b525.jpg"
/// rating : 0
/// ratingCount : 0
/// createdAt : "2025-11-30T17:04:55"

class FaceEntity {
  FaceEntity({
      num? id, 
      num? homeTownId, 
      String? homeTown, 
      num? jobId, 
      String? job, 
      String? education, 
      String? country, 
      String? name, 
      String? lastName, 
      String? knownFor, 
      String? birthdate, 
      String? avatar, 
      num? rating, 
      num? ratingCount, 
      String? createdAt,}){
    _id = id;
    _homeTownId = homeTownId;
    _homeTown = homeTown;
    _jobId = jobId;
    _job = job;
    _education = education;
    _country = country;
    _name = name;
    _lastName = lastName;
    _knownFor = knownFor;
    _birthdate = birthdate;
    _avatar = avatar;
    _rating = rating;
    _ratingCount = ratingCount;
    _createdAt = createdAt;
}

  FaceEntity.fromJson(dynamic json) {
    _id = json['id'];
    _homeTownId = json['homeTownId'];
    _homeTown = json['homeTown'];
    _jobId = json['jobId'];
    _job = json['job'];
    _education = json['education'];
    _country = json['country'];
    _name = json['name'];
    _lastName = json['lastName'];
    _knownFor = json['knownFor'];
    _birthdate = json['birthdate'];
    _avatar = json['avatar'];
    _rating = json['rating'];
    _ratingCount = json['ratingCount'];
    _createdAt = json['createdAt'];
  }
  num? _id;
  num? _homeTownId;
  String? _homeTown;
  num? _jobId;
  String? _job;
  String? _education;
  String? _country;
  String? _name;
  String? _lastName;
  String? _knownFor;
  String? _birthdate;
  String? _avatar;
  num? _rating;
  num? _ratingCount;
  String? _createdAt;
FaceEntity copyWith({  num? id,
  num? homeTownId,
  String? homeTown,
  num? jobId,
  String? job,
  String? education,
  String? country,
  String? name,
  String? lastName,
  String? knownFor,
  String? birthdate,
  String? avatar,
  num? rating,
  num? ratingCount,
  String? createdAt,
}) => FaceEntity(  id: id ?? _id,
  homeTownId: homeTownId ?? _homeTownId,
  homeTown: homeTown ?? _homeTown,
  jobId: jobId ?? _jobId,
  job: job ?? _job,
  education: education ?? _education,
  country: country ?? _country,
  name: name ?? _name,
  lastName: lastName ?? _lastName,
  knownFor: knownFor ?? _knownFor,
  birthdate: birthdate ?? _birthdate,
  avatar: avatar ?? _avatar,
  rating: rating ?? _rating,
  ratingCount: ratingCount ?? _ratingCount,
  createdAt: createdAt ?? _createdAt,
);
  num? get id => _id;
  num? get homeTownId => _homeTownId;
  String? get homeTown => _homeTown;
  num? get jobId => _jobId;
  String? get job => _job;
  String? get education => _education;
  String? get country => _country;
  String? get name => _name;
  String? get lastName => _lastName;
  String? get knownFor => _knownFor;
  String? get birthdate => _birthdate;
  String? get avatar => _avatar;
  num? get rating => _rating;
  num? get ratingCount => _ratingCount;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['homeTownId'] = _homeTownId;
    map['homeTown'] = _homeTown;
    map['jobId'] = _jobId;
    map['job'] = _job;
    map['education'] = _education;
    map['country'] = _country;
    map['name'] = _name;
    map['lastName'] = _lastName;
    map['knownFor'] = _knownFor;
    map['birthdate'] = _birthdate;
    map['avatar'] = _avatar;
    map['rating'] = _rating;
    map['ratingCount'] = _ratingCount;
    map['createdAt'] = _createdAt;
    return map;
  }

}