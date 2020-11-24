import 'dart:convert';

import 'package:hive/hive.dart';

part 'role.model.g.dart';

@HiveType(typeId: 4)
class Role {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String type;

  Role({
    this.id,
    this.name,
    this.description,
    this.type,
  });

  Role copyWith({
    int id,
    String name,
    String description,
    String type,
  }) {
    return Role(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
    };
  }

  factory Role.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Role(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Role.fromJson(String source) => Role.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Role(id: $id, name: $name, description: $description, type: $type)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Role &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ description.hashCode ^ type.hashCode;
  }
}
