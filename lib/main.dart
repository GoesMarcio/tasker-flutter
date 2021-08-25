import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasker/pages/home/home_page.dart';
import 'package:tasker/pages/insert_task/insert_task_page.dart';
import 'package:tasker/pages/splash/splash_page.dart';
import 'package:tasker/shared/theme/app_colors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasker',
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: AppColors.primary),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashPage(),
        "/home": (context) => HomePage(),
        "/insert_task": (context) => InsertTaskPage(),
      },
    );
  }
}
