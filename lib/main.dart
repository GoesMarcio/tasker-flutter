import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/pages/home/home_page.dart';
import 'package:tasker/pages/insert_task/insert_task_page.dart';
import 'package:tasker/pages/splash/splash_page.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Init.instance.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tasker',
              theme: ThemeData(
                  primarySwatch: Colors.blue, primaryColor: AppColors.primary),
              home: HomePage(),
              routes: {
                "/home": (context) => HomePage(),
                "/insert_task": (context) => InsertTaskPage(),
              },
            );
          } else {
            // Show splash screen while waiting for app resources to load:
            return MaterialApp(
                debugShowCheckedModeBanner: false, home: SplashPage());
          }
        });
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future<bool> initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(Duration(seconds: 3));
    return true;
  }
}
