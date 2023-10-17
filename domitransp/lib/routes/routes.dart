import 'package:flutter/material.dart';
import 'package:domitransp/feature/consult/presentation/widgets/consult.dart';
import 'package:domitransp/feature/request/presentation/pages/new_request_page.dart';
import 'package:domitransp/feature/request/presentation/pages/request_list_page.dart';
import 'package:domitransp/feature/web_view/pages/webview_page.dart';
import 'package:domitransp/core/presentation/widgets/home.dart';


final Map<String, WidgetBuilder> routes = {
  'home': (BuildContext context) => Home(),
  'consult': (BuildContext context) => Consult(),
  'webview': (BuildContext context) => WebViewPage(),
  'new_request': (BuildContext context) => NewRequestPage(),
  'list_request': (BuildContext context) => RequestListPage(),
  //TODO: Añadir las demás rutas
  
};
