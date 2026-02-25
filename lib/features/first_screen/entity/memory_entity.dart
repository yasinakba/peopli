class MemoryEntity {
  int? id;
  int? userId;
  String? user;
  String? userAvatar;
  String? username;
  Null? userCityId;
  Null? userCity;
  int? userEducationId;
  Null? userEducation;
  int? faceId;
  String? face;
  int? faceHomeTownId;
  Null? faceHomeTown;
  int? faceEducationId;
  Null? faceEducation;
  int? faceJobId;
  Null? faceJob;
  Null? faceBirthdate;
  String? faceGender;
  String? faceAvatar;
  int? faceRating;
  String? faceKnownFor;
  String? title;
  String? text;
  String? type;
  int? lat;
  int? lng;
  Null? locationAddress;
  String? media;
  int? likesCount;
  bool? isLiked;
  int? commentsCount;
  String? date;
  String? createdAt;

  MemoryEntity(
      {this.id,
        this.userId,
        this.user,
        this.userAvatar,
        this.username,
        this.userCityId,
        this.userCity,
        this.userEducationId,
        this.userEducation,
        this.faceId,
        this.face,
        this.faceHomeTownId,
        this.faceHomeTown,
        this.faceEducationId,
        this.faceEducation,
        this.faceJobId,
        this.faceJob,
        this.faceBirthdate,
        this.faceGender,
        this.faceAvatar,
        this.faceRating,
        this.faceKnownFor,
        this.title,
        this.text,
        this.type,
        this.lat,
        this.lng,
        this.locationAddress,
        this.media,
        this.likesCount,
        this.isLiked,
        this.commentsCount,
        this.date,
        this.createdAt});

  MemoryEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'];
    userAvatar = json['userAvatar'];
    username = json['username'];
    userCityId = json['userCityId'];
    userCity = json['userCity'];
    userEducationId = json['userEducationId'];
    userEducation = json['userEducation'];
    faceId = json['faceId'];
    face = json['face'];
    faceHomeTownId = json['faceHomeTownId'];
    faceHomeTown = json['faceHomeTown'];
    faceEducationId = json['faceEducationId'];
    faceEducation = json['faceEducation'];
    faceJobId = json['faceJobId'];
    faceJob = json['faceJob'];
    faceBirthdate = json['faceBirthdate'];
    faceGender = json['faceGender'];
    faceAvatar = json['faceAvatar'];
    faceRating = json['faceRating'];
    faceKnownFor = json['faceKnownFor'];
    title = json['title'];
    text = json['text'];
    type = json['type'];
    lat = json['lat'];
    lng = json['lng'];
    locationAddress = json['locationAddress'];
    media = json['media'];
    likesCount = json['likesCount'];
    isLiked = json['isLiked'];
    commentsCount = json['commentsCount'];
    date = json['date'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['user'] = this.user;
    data['userAvatar'] = this.userAvatar;
    data['username'] = this.username;
    data['userCityId'] = this.userCityId;
    data['userCity'] = this.userCity;
    data['userEducationId'] = this.userEducationId;
    data['userEducation'] = this.userEducation;
    data['faceId'] = this.faceId;
    data['face'] = this.face;
    data['faceHomeTownId'] = this.faceHomeTownId;
    data['faceHomeTown'] = this.faceHomeTown;
    data['faceEducationId'] = this.faceEducationId;
    data['faceEducation'] = this.faceEducation;
    data['faceJobId'] = this.faceJobId;
    data['faceJob'] = this.faceJob;
    data['faceBirthdate'] = this.faceBirthdate;
    data['faceGender'] = this.faceGender;
    data['faceAvatar'] = this.faceAvatar;
    data['faceRating'] = this.faceRating;
    data['faceKnownFor'] = this.faceKnownFor;
    data['title'] = this.title;
    data['text'] = this.text;
    data['type'] = this.type;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['locationAddress'] = this.locationAddress;
    data['media'] = this.media;
    data['likesCount'] = this.likesCount;
    data['isLiked'] = this.isLiked;
    data['commentsCount'] = this.commentsCount;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
