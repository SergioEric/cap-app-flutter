import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';

// import 'helpers/helpers.dart';
import 'pages/login_page/login.page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cap Sahagún',
      theme: ThemeData(
        primarySwatch: LolColors.c1070_2,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
      ),
      home: LoginPage(),
    );
  }
}
