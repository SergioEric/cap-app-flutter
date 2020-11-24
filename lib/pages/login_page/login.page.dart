import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';
import 'package:lol_colors_flutter/color_extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../main.dart';

class LoginPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final totalHeight = media.size.height - MediaQuery.of(context).padding.top;
    // print(_rndDropsList);
    final bgColor = LolColors.c1658_1;
    print("rebuild");

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          brightness: bgColor.isDark() ? Brightness.light : Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: media.size.width,
              height: totalHeight,
            ),
            Positioned(
              // alignment: Alignment.topCenter,
              top: totalHeight * 0.10,
              left: media.size.width * 0.25,
              right: media.size.width * 0.25,
              child: Image.asset(
                "assets/logo.webp",
                // width: logoWidth,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              // alignment: Alignment.bottomCenter,
              child: FormWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  // const FormWidget({Key key, @required this.colors}) : super(key: key);

  // final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    final color1 = LolColors.c1070_1;
    final color2 = LolColors.c1070_2;
    final color3 = LolColors.c671_2;
    final color4 = LolColors.c1070_4;

    final c3IsDark = color3.isDark();
    final textFieldHintStyle = TextStyle(
      color: c3IsDark ? Colors.black : Colors.white,
    );
    final textFieldLabelStyle = TextStyle(
      color: c3IsDark ? Colors.black54 : Colors.white54,
    );

    return Container(
      // alignment: Alignment.bottomCenter,
      width: media.size.width,
      height: media.size.height * 0.45,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: media.size.width * 0.8,
            child: TextFormField(
              style: textFieldHintStyle,
              decoration: InputDecoration(
                hintText: "email@domain.com",
                labelText: "Email",
                hintStyle: textFieldHintStyle,
                labelStyle: textFieldLabelStyle,
              ),
            ),
            decoration: BoxDecoration(
              color: color3,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: media.size.width * 0.8,
            margin: EdgeInsets.only(top: 14),
            child: TextFormField(
              obscureText: true,
              style: textFieldHintStyle,
              decoration: InputDecoration(
                // hintText: "",
                labelText: "Contraseña",
                hintStyle: textFieldHintStyle,
                labelStyle: textFieldLabelStyle,
              ),
            ),
            decoration: BoxDecoration(
              color: color3,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            // margin: EdgeInsets.only(top: 20),
            // margin: EdgeInsets.only(bottom: media.viewInsets.bottom),
            child: TextButton(
              child: Text("CONTINUAR"),
              onPressed: () {
                context.read(authProvider).state = true;
              },
              style: TextButton.styleFrom(
                backgroundColor: color1,
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ),
          Counter()
        ],
      ),
      decoration: BoxDecoration(
        color: color4,
        gradient: LinearGradient(
          colors: [color2, color4],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33),
          topRight: Radius.circular(33),
        ),
      ),
    );
  }
}

final count = StateProvider((_) => 0);

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("asass"),
        HookBuilder(
          builder: (context) {
            final countState = useProvider(count);
            return Container(
              child: Column(
                children: [
                  Text(countState.state.toString()),
                  TextButton(
                    onPressed: () {
                      final a = context.read(count).state;
                      context.read(count).state = a + 1;
                    },
                    child: Text("increment"),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
