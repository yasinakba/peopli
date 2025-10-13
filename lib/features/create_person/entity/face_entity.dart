/// id : 58
/// homeTownId : 55
/// homeTown : "vegas"
/// jobId : 24
/// job : "۲۲۲۲۲"
/// education : "Worker3333"
/// country : "united state "
/// name : "Yasdfasf"
/// lastName : "teest"
/// knownFor : "test"
/// birthdate : "2007-01-04"
/// avatar : "42_880b.jpg"
/// createdAt : "2025-10-13T16:45:53"

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
    map['createdAt'] = _createdAt;
    return map;
  }

}