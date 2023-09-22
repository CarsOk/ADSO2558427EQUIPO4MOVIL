import 'package:domitransp/feature/consult/presentation/widgets/consult.dart';
import 'package:domitransp/feature/web_view/pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:domitransp/core/presentation/widgets/home.dart';

final Map<String, WidgetBuilder> routes = {
  'home': (BuildContext context) => Home(),
  'consult': (BuildContext context) => Consult(),
  'webview': (BuildContext context) => WebViewPage(),
  //TODO: Añadir las demás rutas
};
