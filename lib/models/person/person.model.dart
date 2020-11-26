import 'dart:convert';

import 'package:hive/hive.dart';

part 'person.model.g.dart';

@HiveType(typeId: 5)
class Person extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String nombre;

  @HiveField(2)
  final int edad;

  @HiveField(3)
  final bool sexo;

  @HiveField(4)
  final String identificacion;

  Person({
    this.id,
    this.nombre,
    this.edad,
    this.sexo,
    this.identificacion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'edad': edad,
      'sexo': sexo,
      'identificacion': identificacion,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Person(
      id: map['id'],
      nombre: map['nombre'],
      edad: map['edad'],
      sexo: map['sexo'],
      identificacion: map['identificacion'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Person(id: $id, nombre: $nombre, edad: $edad, sexo: $sexo, identificacion: $identificacion)';
  }
}
