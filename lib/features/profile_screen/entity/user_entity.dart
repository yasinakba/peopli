import 'package:test_test_test/features/first_screen/entity/memory_entity.dart';

import '../../create_person/entity/face_entity.dart';

class UserEntity {
  final int id;
  final int educationId;
  final String role;
  final String token;
  final String username;
  final String displayName;
  final String password;
  final String avatar;
  final String email;
  final int cityId;
  final Location? lastKnownLocation;
  final String birthdate;
  final String createdAt;

  UserEntity.UserEntity({
    required this.id,
    required this.educationId,
    required this.role,
    required this.token,
    required this.username,
    required this.displayName,
    required this.password,
    required this.avatar,
    required this.email,
    required this.cityId,
    required this.lastKnownLocation,
    required this.birthdate,
    required this.createdAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity.UserEntity(
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
      lastKnownLocation: json['lastKnownLocation'] != null
          ? Location.fromJson(json['lastKnownLocation'])
          : null,
      birthdate: json['birthdate'],
      createdAt: json['createdAt'],
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
      'lastKnownLocation': lastKnownLocation?.toJson(),
      'birthdate': birthdate,
      'createdAt': createdAt,
    };
  }
}
class Location {
  final double x; // longitude
  final double y; // latitude
  final int srid;

  Location({
    required this.x,
    required this.y,
    required this.srid,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      srid: json['srid'] ?? 4326,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'srid': srid,
    };
  }
}

