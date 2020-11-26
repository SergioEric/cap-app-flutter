import 'package:cap_sahagun/models/subject/subject.model.dart';
import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:link_text/link_text.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';
import 'package:lol_colors_flutter/color_extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global.providers.dart';

final subjetcsProvider =
    FutureProvider.autoDispose<List<SubjectModel>>((ref) async {
  final token = ref.watch(userInfoProvider).jwt;
  final response = await ref.watch(client).get(
        "$baseUrl/materias",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
  List<SubjectModel> meetings = (response.data as List<dynamic>)
      .map((e) => SubjectModel.fromMap(e))
      .toList();
  return meetings;
});

class SubjectPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final subjects = useProvider(subjetcsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Materias Disponibles"),
      ),
      body: subjects.when(
        data: (value) {
          if (value.isEmpty) return Text("Sin materias");

          return ListView(
            children: value
                .map(
                  (subject) => ListTile(
                    title: Text(subject.nombre),
                    subtitle: Text("Grado: ${subject.grado}"),
                  ),
                )
                .toList(),
          );
        },
        loading: () => Container(
          margin: EdgeInsets.only(top: 120),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) {
          return Text("$error");
        },
      ),
    );
  }
}
