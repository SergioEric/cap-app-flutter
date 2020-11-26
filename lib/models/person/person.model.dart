import 'dart:convert';

class Person {
  final int id;
  final String nombre;
  final int edad;
  final bool sexo;
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
