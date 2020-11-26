import 'package:cap_sahagun/models/auth/auth.model.dart';
import 'package:cap_sahagun/models/family_parameters/rol.parameter.dart';
import 'package:cap_sahagun/models/person/person.model.dart';
import 'package:cap_sahagun/models/role/role.model.dart';
import 'package:cap_sahagun/pages/material_page/material.page.dart';
import 'package:cap_sahagun/providers/base.url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' hide BuildContextX;
import '../../global.providers.dart';
import '../../providers/new.context.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

final logOutProvider = FutureProvider<void>((ref) async {
  final repo = ref.watch(loginRepository);

  await repo.logOut();
  ref.watch(authProvider).state = false;
});

final userInfoProvider = Provider.autoDispose<Auth>((_) {
  final box = Hive.box<Auth>("auth");

  return box.get("session");
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

  // print(person);

  return person;
});

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeStudent(),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
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
          title: Text("${role.name} - ${auth.user.email} - ${auth.user.id}"),
          bottom: AppBar(
            title: userInformationState.when(
              data: (person) {
                return Text("${person.nombre}");
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stackTrace) => Text(
                "Sin datos asignados",
                style: TextStyle(fontSize: 12),
              ),
            ),
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
        body: _widgetOptions.elementAt(navIndex.state),
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

class HomeStudent extends StatelessWidget {
  const HomeStudent();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      // mainAxisSpacing: 15,
      childAspectRatio: 6 / 3,
      // childAspectRatio: 9.1 / 7, //-> ~1.3
      children: [
        Section(
            title: "Materiales -Recursos",
            imagePath: "assets/icons/materiales.png",
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => MyMaterialPage()),
              );
            }),
        Section(
          title: "Materias",
          imagePath: "assets/icons/materiales.png",
        ),
        Section(
          title: "Matricula",
          imagePath: "assets/icons/materiales.png",
        ),
        Section(
          title: "Pagos",
          imagePath: "assets/icons/materiales.png",
        ),
        // Section(
        //   title: "Materiales",
        //   imagePath: "assets/icons/materiales.png",
        // ),
      ],
    );
  }
}

class Section extends StatelessWidget {
  const Section(
      {Key key, this.imagePath, this.title, this.description, this.onTap})
      : super(key: key);

  final String imagePath;
  final String title;
  final String description;
  final VoidCallback onTap;

  static const _height = 120.0;
  @override
  Widget build(BuildContext context) {
    // final media = MediaQuery.of(context);
    return Container(
      // color: Colors.transparent,
      // width: media.size.width * 0.20,
      // height: _height,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  imagePath,
                  height: _height * 1,
                  // fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Text(
                        description ?? fakeDescription,
                        overflow: TextOverflow.fade,
                        // maxLines: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final fakeDescription =
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
