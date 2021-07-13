import 'package:coordenador/course/course_addedit_connector.dart';
import 'package:coordenador/course/course_archived_connector.dart';
import 'package:coordenador/module/module_addedit_connector.dart';
import 'package:coordenador/module/module_connector.dart';
import 'package:coordenador/resource/resource_connector.dart';
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
    '/course_archived': (BuildContext context) => CourseArchivedConnector(),
    '/module': (BuildContext context) => ModuleConnector(
          courseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/module_addedit': (BuildContext context) => ModuleAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/resource': (BuildContext context) => ResourceConnector(
          moduleId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
  };
}
