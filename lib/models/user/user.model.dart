import 'dart:convert';

import 'package:hive/hive.dart';

import '../role/role.model.dart';

part 'user.model.g.dart';

@HiveType(typeId: 3)
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final bool confirmed;

  @HiveField(4)
  final bool blocked;

  @HiveField(5)
  final Role role;

  User({
    this.id,
    this.username,
    this.email,
    this.confirmed,
    this.blocked,
    this.role,
  });

  User copyWith({
    int id,
    String username,
    String email,
    bool confirmed,
    bool blocked,
    Role role,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'confirmed': confirmed,
      'blocked': blocked,
      'role': role?.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      confirmed: map['confirmed'],
      blocked: map['blocked'],
      role: Role.fromMap(map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, confirmed: $confirmed, blocked: $blocked, role: $role)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.id == id &&
        o.username == username &&
        o.email == email &&
        o.confirmed == confirmed &&
        o.blocked == blocked &&
        o.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        confirmed.hashCode ^
        blocked.hashCode ^
        role.hashCode;
  }
}
