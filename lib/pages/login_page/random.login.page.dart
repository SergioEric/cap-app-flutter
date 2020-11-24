import 'package:flutter/material.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';
import 'package:lol_colors_flutter/color_extension.dart';
import '../../helpers/helpers.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final _randomLolColor = random(all_lol_colors.length);

    final _rndPickedColor = random(4);

    final _rndShadeColor = shadesMaterial[random(shadesMaterial.length)];

    // final bgColor = all_lol_colors[lolColors[0]][1][500];
    final bgColor = all_lol_colors[lolColors[_randomLolColor]][_rndPickedColor]
        [_rndShadeColor];

    // final logoWidth = size.width * 0.5;

    final bgColorIsDark = bgColor.isDark();

    final textColor = bgColorIsDark ? Colors.black : Colors.white;

    final _rndDropsList = randomColorPositions(_rndPickedColor);
    // final rnd1 = _rndPickedColor;
    final rnd2 = _rndDropsList[1];
    final rnd3 = _rndDropsList[2];
    final rnd4 = _rndDropsList[3];

    final color1 = bgColor;
    final color2 = all_lol_colors[lolColors[_randomLolColor]][rnd2]
        [shadesMaterial[random(shadesMaterial.length)]];
    final color3 = all_lol_colors[lolColors[_randomLolColor]][rnd3]
        [shadesMaterial[random(shadesMaterial.length)]];
    final color4 = all_lol_colors[lolColors[_randomLolColor]][rnd4]
        [shadesMaterial[random(shadesMaterial.length)]];
    final totalHeight = size.height - MediaQuery.of(context).padding.top;
    // print(_rndDropsList);
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
              width: size.width,
              height: totalHeight,
            ),
            Positioned(
              // alignment: Alignment.topCenter,
              top: totalHeight * 0.10,
              left: size.width * 0.25,
              right: size.width * 0.25,
              child: Image.asset(
                "assets/logo.webp",
                // width: logoWidth,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              bottom: 0,
              // alignment: Alignment.bottomCenter,
              child: FormWidget(
                colors: [
                  color1,
                  color2,
                  color3,
                  color4,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  const FormWidget({Key key, @required this.colors}) : super(key: key);

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final color1 = colors[0];
    final color2 = colors[1];
    final color3 = colors[2];
    final color4 = colors[3];

    final c2IsDark = color2.isDark();
    final textFieldHintStyle = TextStyle(
      color: c2IsDark ? Colors.black : Colors.white,
    );
    final textFieldLabelStyle = TextStyle(
      color: c2IsDark ? Colors.black54 : Colors.white54,
    );

    return Container(
      // alignment: Alignment.bottomCenter,
      width: size.width,
      height: size.height * 0.45,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            width: size.width * 0.8,
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
              color: color2,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            width: size.width * 0.8,
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
              color: color2,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: color4,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(33),
          topRight: Radius.circular(33),
        ),
      ),
    );
  }
}
