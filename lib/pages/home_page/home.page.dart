import 'package:cap_sahagun/models/auth/auth.model.dart';
import 'package:cap_sahagun/models/family_parameters/rol.parameter.dart';
import 'package:cap_sahagun/models/person/person.model.dart';
import 'package:cap_sahagun/models/role/role.model.dart';
import 'package:cap_sahagun/pages/home_page/home.tutor.widget.dart';
import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide BuildContextX;
import '../../global.providers.dart';
import '../../providers/new.context.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'home.student.widget.dart';

final logOutProvider = FutureProvider<void>((ref) async {
  final repo = ref.watch(loginRepository);

  await repo.logOut();
  ref.watch(authProvider).state = false;
});

final selectedIndex = StateProvider<int>((_) => 0);

final userInformation = FutureProvider.family
    .autoDispose<Person, RolParameter>((ref, params) async {
  // ref.maintainState = true;
  final token = ref.watch(userInfoProvider).jwt;
  // print(params);
  final response = await ref.watch(client).get(
        "$baseUrl/${params.rol}?usuario=${params.userId}",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
  // print(response);
  var person = Person.fromMap(response.data[0]);

  if (person != null) {
    var box = await Hive.openBox<Person>("person");
    box.put("person", person);
  }
  // print(person);

  return person;
});

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  static const List<Widget> _widgetStudentOptions = <Widget>[
    HomeStudent(),
    Text(
      'Index 1: Meetings - Student',
    ),
    Text(
      'Index 2: More - Student',
    ),
  ];

  static const List<Widget> _widgetTutorOptions = <Widget>[
    HomeTutors(),
    Text(
      'Index 1: Meetings - Tutor',
    ),
    Text(
      'Index 2: More - Tutor',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return HookBuilder(builder: (context) {
      final Auth auth = useProvider(userInfoProvider);
      //ROL id 4 = TUTOR;
      //ROL id 3 = ESTUDIANTE;
      final Role role = auth.user.role;
      final navIndex = useProvider(selectedIndex);
      final userRole = role.type == 'tutor' ? "tutors" : "estudiantes";
      final userInformationState = useProvider(
        userInformation(
          RolParameter(
            userId: auth.user.id,
            rol: userRole,
          ),
        ),
      );
      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [
                  Text(
                    "${role.name} - ${auth.user.email} - id:${auth.user.id}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              userInformationState.when(
                data: (person) {
                  return Row(
                    children: [
                      Text(
                        "${person.nombre}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
                loading: () => Container(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                error: (error, stackTrace) => Row(
                  children: [
                    Text(
                      "Sin datos asignados",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                context.readPod(logOutProvider).whenData((value) => null);
              },
            )
          ],
        ),
        body: role.type == 'tutor'
            ? _widgetTutorOptions.elementAt(navIndex.state)
            : _widgetStudentOptions.elementAt(navIndex.state),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Encuentros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: 'más',
            ),
          ],
          currentIndex: navIndex.state,
          selectedItemColor: Colors.amber[800],
          onTap: (value) => context.readPod(selectedIndex).state = value,
        ),
      );
    });
  }
}
