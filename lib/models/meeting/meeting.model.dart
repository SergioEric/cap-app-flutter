import 'dart:convert';

import '../materials-resources/materials.model.dart';
import '../person/person.model.dart';

class Meeting {
  Meeting(this.id, this.horario, this.tutor, this.url, this.materiales,
      this.estudiantes, this.dias);

  final int id;
  final String horario;
  final Person tutor;
  final String url;
  final String dias;
  final List<Materials> materiales;

  final List<Person> estudiantes;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Horario': horario,
      'Tutor': tutor?.toMap(),
      'Url': url,
      'Materiales': materiales?.map((x) => x?.toMap())?.toList(),
      'Estudiantes': estudiantes?.map((x) => x?.toMap())?.toList(),
      'dias': dias,
    };
  }

  factory Meeting.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Meeting(
      map['id'],
      map['Horario'],
      Person.fromMap(map['Tutor']),
      map['Url'],
      List<Materials>.from(map['Materiales']?.map((x) => Materials.fromMap(x))),
      List<Person>.from(map['Estudiantes']?.map((x) => Person.fromMap(x))),
      map['dias'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Meeting.fromJson(String source) =>
      Meeting.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Meeting(id: $id, horario: $horario, tutor: $tutor, url: $url, dias:$dias, materiales: $materiales, estudiantes: $estudiantes)';
  }
}
