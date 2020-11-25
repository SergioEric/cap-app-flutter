import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lol_colors_flutter/lol_colors_flutter.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'helpers/helpers.dart';
import 'global.providers.dart';
import 'models/auth/auth.model.dart';
import 'pages/login_page/login.page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await Hive.initFlutter();

  Hive.registerAdapter(AuthAdapter());

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, watch, __) {
      final navState = watch(navigator);
      // final authState = watch(authProvider);
      // final authSession = watch(session);
      return MaterialApp(
        navigatorKey: navState,
        debugShowCheckedModeBanner: false,
        title: 'Cap Sahagún',
        theme: ThemeData(
          primarySwatch: LolColors.c1070_2,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.ralewayTextTheme(Theme.of(context).textTheme),
        ),
        // home: LoginPage(),
        builder: (context, child) {
          return ProviderListener<StateController<bool>>(
            provider: authProvider,
            child: child,
            onChange: (context, auth) {
              print(auth.state);
              if (auth.state)
                navState.currentState.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (_) => false,
                );
              else
                navState.currentState.pushAndRemoveUntil(
                  LoginPage.route(),
                  (_) => false,
                );
            },
          );
        },
        onGenerateRoute: (_) => SplashScreen.route(),
      );
    });
  }
}

class SplashScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderListener<AsyncValue<Auth>>(
        provider: session,
        child: Center(
          child: Text("Splash Screen"),
        ),
        onChange: (context, value) {
          if (value.data.value != null) {
            context.read(authProvider).state = true;
            return;
          }
          context.read(authProvider).state = false;
          print("Splash $value");
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
