import 'package:cap_sahagun/models/materials-resources/materials.model.dart';
import 'package:cap_sahagun/models/meeting/meeting.model.dart';
import 'package:cap_sahagun/models/person/person.model.dart';
import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:link_text/link_text.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';
import 'package:lol_colors_flutter/color_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../global.providers.dart';

final meetingProvider = FutureProvider.autoDispose<List<Meeting>>((ref) async {
  final box = Hive.box<Person>("person");
  final id = box.get("person").id;
  print(id);

  final token = ref.watch(userInfoProvider).jwt;
  final response = await ref.watch(client).get(
        "$baseUrl/encuentros?Tutor=$id",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
  List<Meeting> meetings =
      (response.data as List<dynamic>).map((e) => Meeting.fromMap(e)).toList();
  // meetings.map((e) => Meeting.fromMap(e));
  print(response.data);
  return meetings;
});

class MeetingPageTutors extends StatelessWidget {
  const MeetingPageTutors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tus encuentros"),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (_, watch, __) {
              final state = watch(meetingProvider);

              return state.when(
                data: (value) {
                  if (value.isEmpty)
                    return Container(
                        margin: EdgeInsets.only(top: 120),
                        child: Center(
                          child: Text("Sin Encuentros"),
                        ));
                  return Expanded(
                    child: ListView(
                      children: value
                          .map(
                            (meet) => RawMeeting(
                              meeting: meet,
                            ),
                          )
                          .toList(),
                    ),
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
              );
            },
          ),
          // Text('MaterialPage')
        ],
      ),
    );
  }
}

class RawMeeting extends HookWidget {
  const RawMeeting({Key key, this.meeting}) : super(key: key);
  final Meeting meeting;

  showMaterials(BuildContext context) async {
    final media = MediaQuery.of(context);
    return await showDialog(
      barrierColor: Colors.black87,
      context: context,
      child: HookBuilder(
        builder: (context) {
          final isEditing = useState(0); // meeting id when is editing
          // final
          return Theme(
            data: ThemeData.dark(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Center(
                      child: Text(
                        "Materiales",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: ListView(
                        children: meeting.materiales.map(
                          (Materials mat) {
                            final _editing = isEditing.value == mat.id;
                            return Container(
                              height:
                                  (_editing) ? media.size.height * 0.8 : null,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LinkText(
                                        text: mat.contenido,
                                        textAlign: TextAlign.start,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
                                              isEditing.value = mat.id;
                                            },
                                            icon: Icon(
                                              _editing
                                                  ? Icons.send
                                                  : Icons.edit,
                                              size: 18,
                                            ),
                                            label: _editing
                                                ? Text("Enviar")
                                                : Text("Editar"),
                                            style: TextButton.styleFrom(
                                                primary: LolColors.c1658_2),
                                          ),
                                          _editing
                                              ? TextButton.icon(
                                                  onPressed: () {
                                                    isEditing.value = -1;
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                  ),
                                                  label: Text("Cerrar"),
                                                  style: TextButton.styleFrom(
                                                      primary:
                                                          LolColors.c1658_2),
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget drawMaterialsContent(BuildContext context) {
    final materials = meeting.materiales;
    // width: MediaQuery.of(context).size.width * 0.35,
    // height: 50,
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: (materials.isNotEmpty)
          ? [
              InkWell(
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: Text(
                    "ver materiales",
                    style: TextStyle(
                      color: theme.cardColor.isDark()
                          ? LolColors.c1070_1
                          : LolColors.c1369_3,
                    ),
                  ),
                ),
                onTap: () => showMaterials(context),
              ),
            ]
          : [
              Row(
                children: [
                  Text(
                    "Sin materiales",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ],
              )
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // print(cardColor);
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        elevation: 5,
        // color: theme.cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${meeting.horario} - ${meeting.dias ?? '¡sin asignar días!'}",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tutor " + "${meeting.tutor.nombre ?? 'SIN ASIGNAR'}",
                  ),
                  drawMaterialsContent(context),
                  // Text("${meeting.materiales.length}")
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => _launchURL(context, meeting.url),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        "ABRIR ENLACE",
                        style: TextStyle(
                          color: theme.cardColor.isDark()
                              ? LolColors.c4714_1[400]
                              : LolColors.c2209_3[400],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "No se pudo abrir el enlace",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
