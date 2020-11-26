import 'dart:convert';

class SubjectModel {
  SubjectModel({
    this.id,
    this.nombre,
    this.grado,
  });

  final int id;
  final String nombre;
  final String grado;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'grado': grado,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SubjectModel(
      id: map['id'],
      nombre: map['nombre'],
      grado: map['grado'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source));

  @override
  String toString() => 'SubjectModel(id: $id, nombre: $nombre, grado: $grado)';
}
