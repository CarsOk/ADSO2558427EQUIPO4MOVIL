import 'package:domitransp/feature/create_order/presentation/page/create_order_page.dart';
import 'package:domitransp/feature/order/presentation/page/order_page.dart';
import 'package:domitransp/feature/sign_in/presentation/page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:domitransp/feature/consult/presentation/widgets/consult.dart';
import 'package:domitransp/feature/request/presentation/pages/new_request_page.dart';
import 'package:domitransp/feature/request/presentation/pages/request_list_page.dart';
import 'package:domitransp/feature/web_view/pages/webview_page.dart';
import 'package:domitransp/feature/home/presentation/page/home_page.dart';

import '../core/presentation/widgets/body.dart';

final Map<String, WidgetBuilder> routes = {
  'home': (BuildContext context) => HomePage(),
  'consult': (BuildContext context) => Consult(),
  'webview': (BuildContext context) => WebViewPage(),
  'new_request': (BuildContext context) => NewRequestPage(),
  'list_request': (BuildContext context) => RequestListPage(),
  'sign_in': (BuildContext context) => SignInPage(),
  'body': (BuildContext context) => Body(),
  'second': (context) => HomePage(
      numeroPaginado: ModalRoute.of(context)!.settings.arguments as int),
  'mis_envios': (BuildContext context) => OrderPage(),
  'nuevo_envio': (BuildContext context) => CreateOrderPage(),
};
