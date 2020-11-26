import 'package:cap_sahagun/models/meeting/meeting.model.dart';
import 'package:cap_sahagun/models/person/person.model.dart';
import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../global.providers.dart';

final materialsProvider =
    FutureProvider.autoDispose<List<Meeting>>((ref) async {
  final box = Hive.box<Person>("person");
  final id = box.get("person").id;

  final token = ref.watch(userInfoProvider).jwt;
  final response = await ref.watch(client).get(
        "$baseUrl/encuentros?Estudiantes=$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
  List<Meeting> meetings =
      (response.data as List<dynamic>).map((e) => Meeting.fromMap(e)).toList();
  // meetings.map((e) => Meeting.fromMap(e));
  // print(response.data);
  return meetings;
});

class MyMaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: LolColors.c1294_2,
          title: Text(
            "Materiales - Recursos",
            // style: ,
          ),
        ),
        body: Column(
          children: [
            Consumer(
              builder: (_, watch, __) {
                final state = watch(materialsProvider);

                return state.when(
                  data: (value) {
                    return Expanded(
                      child: ListView(
                        children:
                            value.map((meet) => Text("${meet.tutor}")).toList(),
                      ),
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (error, stackTrace) {
                    return Text("$error");
                  },
                );
              },
            ),
            Center(
              child: Text('MaterialPage'),
            ),
          ],
        ),
      ),
    );
  }
}
