import 'package:flutter/material.dart';
import 'package:domitransp/feature/consult/presentation/widgets/consult.dart';
import 'package:domitransp/feature/request/presentation/pages/new_request_page.dart';
import 'package:domitransp/feature/request/presentation/pages/request_list_page.dart';
import 'package:domitransp/feature/web_view/pages/webview_page.dart';
import 'package:domitransp/feature/home/presentation/page/home_page.dart';

import '../feature/request/presentation/pages/request_detail_page.dart';

final Map<String, WidgetBuilder> routes = {
  'home': (BuildContext context) => HomePage(),
  'consult': (BuildContext context) => Consult(),
  'webview': (BuildContext context) => WebViewPage(),
  'new_request': (BuildContext context) => NewRequestPage(),
  'list_request': (BuildContext context) => RequestListPage(),
  //TODO: Añadir las demás rutas
  
};
