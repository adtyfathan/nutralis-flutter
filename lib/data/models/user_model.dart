import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String uid;
  final String username;
  final String? email;
  final String avatar;
  final DateTime createdAt;

  const UserModel({
    required this.uid,
    required this.username,
    this.email,
    required this.avatar,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      email: json['email'],
      avatar: json['avatar'] ?? 'avatar1',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? username,
    String? email,
    String? avatar,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [uid, username, email, avatar, createdAt];
}
