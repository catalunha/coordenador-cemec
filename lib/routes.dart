import 'package:flutter/material.dart';
import 'package:coordenador/home/home_page_connector.dart';
import 'package:coordenador/login/login_connector.dart';
import 'package:coordenador/splash/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
  };
}
