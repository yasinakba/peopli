import 'package:test_test_test/features/create_person/entity/face_entity.dart';
import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';

class  UserEntity {
  final int id;
  final int? educationId;
  final String role;
  final String token;
  final String username;
  final String displayName;
  final String password;
  final String avatar;
  final String? email;
  final int? cityId;
  final String? lastKnownLocation;
  final String? birthdate;
  final DateTime? createdAt;
  final dynamic city;
  final List<dynamic> comment;
  final dynamic education;
  final List<FaceEntity> face;
  final List<dynamic> like;
  final List<MemoryEntity> memory;
  final List<dynamic> userOption;
  final List<dynamic> vote;

  UserEntity({
    required this.id,
    this.educationId,
    required this.role,
    required this.token,
    required this.username,
    required this.displayName,
    required this.password,
    required this.avatar,
    this.email,
    this.cityId,
    this.lastKnownLocation,
    this.birthdate,
    this.createdAt,
    this.city,
    required this.comment,
    this.education,
    required this.face,
    required this.like,
    required this.memory,
    required this.userOption,
    required this.vote,
  });
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      educationId: json['educationId'],
      role: json['role'],
      token: json['token'],
      username: json['username'],
      displayName: json['displayName'],
      password: json['password'],
      avatar: json['avatar'],
      email: json['email'],
      cityId: json['cityId'],
      lastKnownLocation: json['lastKnownLocation'],
      birthdate: json['birthdate'] != null ? (json['birthdate']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      city: json['city'],
      comment: json['comment'] != null ? List<dynamic>.from(json['comment']) : [],
      education: json['education'],
      face: json['face'] != null ? List<FaceEntity>.from(json['face']) : [],
      like: json['like'] != null ? List<dynamic>.from(json['like']) : [],
      memory: json['memory'] != null
          ? List<MemoryEntity>.from(
          json['memory'].map((x) => MemoryEntity.fromJson(x)))
          : [],
      userOption: json['userOption'] != null ? List<dynamic>.from(json['userOption']) : [],
      vote: json['vote'] != null ? List<dynamic>.from(json['vote']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'educationId': educationId,
      'role': role,
      'token': token,
      'username': username,
      'displayName': displayName,
      'password': password,
      'avatar': avatar,
      'email': email,
      'cityId': cityId,
      'lastKnownLocation': lastKnownLocation,
      'birthdate': birthdate,
      'createdAt': createdAt?.toIso8601String(),
      'city': city,
      'comment': comment,
      'education': education,
      'face': face,
      'like': like,
      'memory': memory,
      'userOption': userOption,
      'vote': vote,
    };
  }
}
