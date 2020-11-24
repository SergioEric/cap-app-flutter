import 'dart:convert';

import 'package:hive/hive.dart';

import '../user/user.model.dart';

part 'auth.model.g.dart';

@HiveType(typeId: 2)
class Auth {
  @HiveField(0)
  final String jwt;

  @HiveField(1)
  final User user;

  Auth({
    this.jwt,
    this.user,
  });

  Auth copyWith({
    String jwt,
    User user,
  }) {
    return Auth(
      jwt: jwt ?? this.jwt,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jwt': jwt,
      'user': user?.toMap(),
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Auth(
      jwt: map['jwt'],
      user: User.fromMap(map['user']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source));

  @override
  String toString() => 'Auth(jwt: $jwt, user: $user)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Auth && o.jwt == jwt && o.user == user;
  }

  @override
  int get hashCode => jwt.hashCode ^ user.hashCode;
}
