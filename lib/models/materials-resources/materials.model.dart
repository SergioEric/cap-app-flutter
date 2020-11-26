import 'dart:convert';

class Materials {
  Materials(
    this.id,
    this.contenido,
    this.fecha,
  );

  final int id;
  final String contenido;
  final String fecha;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contenido': contenido,
      'fecha': fecha,
    };
  }

  factory Materials.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Materials(
      map['id'],
      map['contenido'],
      map['fecha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Materials.fromJson(String source) =>
      Materials.fromMap(json.decode(source));

  @override
  String toString() =>
      'Materials(id: $id, contenido: $contenido, fecha: $fecha)';
}
