import 'package:coordenador/course/course_addedit_connector.dart';
import 'package:coordenador/module/module_page.dart';
import 'package:flutter/material.dart';
import 'package:coordenador/home/home_page_connector.dart';
import 'package:coordenador/login/login_connector.dart';
import 'package:coordenador/splash/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/course_addedit': (BuildContext context) => CourseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/module': (BuildContext context) => ModulePage(),
  };
  // static onGenerateRoute(RouteSettings settings) {
  //   var routes2 = <String, WidgetBuilder>{
  //     '/': ( context) => SplashConnector(),
  //     '/login': ( context) => LoginConnector(),
  //     '/home': ( context) => HomePageConnector(),
  //     '/course_addedit': ( context) =>
  //         CourseAddEditConnector(addOrEditId: settings.arguments.toString()),
  //   };
  //   WidgetBuilder builder = routes2[settings.name];
  // }
}
