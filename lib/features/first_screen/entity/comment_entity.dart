class CommentEntity {
  int? id;
  int? memoryId;
  int? faceId;
  int? memoryPosterId;
  String? memoryTitle;
  String? memoryType;
  String? memoryPoster;
  String? memoryPosterAvatar;
  String? faceName;
  int? faceRating;
  String? faceAvatar;
  String? faceKnownFor;
  Null? faceBirthdate;
  Null? faceHometown;
  String? text;
  User? user;
  String? type;
  String? createdAt;

  CommentEntity(
      {this.id,
        this.memoryId,
        this.faceId,
        this.memoryPosterId,
        this.memoryTitle,
        this.memoryType,
        this.memoryPoster,
        this.memoryPosterAvatar,
        this.faceName,
        this.faceRating,
        this.faceAvatar,
        this.faceKnownFor,
        this.faceBirthdate,
        this.faceHometown,
        this.text,
        this.user,
        this.type,
        this.createdAt});

  CommentEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memoryId = json['memoryId'];
    faceId = json['faceId'];
    memoryPosterId = json['memoryPosterId'];
    memoryTitle = json['memoryTitle'];
    memoryType = json['memoryType'];
    memoryPoster = json['memoryPoster'];
    memoryPosterAvatar = json['memoryPosterAvatar'];
    faceName = json['faceName'];
    faceRating = json['faceRating'];
    faceAvatar = json['faceAvatar'];
    faceKnownFor = json['faceKnownFor'];
    faceBirthdate = json['faceBirthdate'];
    faceHometown = json['faceHometown'];
    text = json['text'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    type = json['type'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memoryId'] = this.memoryId;
    data['faceId'] = this.faceId;
    data['memoryPosterId'] = this.memoryPosterId;
    data['memoryTitle'] = this.memoryTitle;
    data['memoryType'] = this.memoryType;
    data['memoryPoster'] = this.memoryPoster;
    data['memoryPosterAvatar'] = this.memoryPosterAvatar;
    data['faceName'] = this.faceName;
    data['faceRating'] = this.faceRating;
    data['faceAvatar'] = this.faceAvatar;
    data['faceKnownFor'] = this.faceKnownFor;
    data['faceBirthdate'] = this.faceBirthdate;
    data['faceHometown'] = this.faceHometown;
    data['text'] = this.text;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class User {
  int? id;
  String? displayName;
  String? avatar;

  User({this.id, this.displayName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    data['avatar'] = this.avatar;
    return data;
  }
}
