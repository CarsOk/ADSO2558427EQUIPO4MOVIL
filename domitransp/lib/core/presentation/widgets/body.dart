import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:domitransp/feature/account/presentation/page/account_page.dart';
import 'package:domitransp/feature/agency/presentation/page/agency_page.dart';
import 'package:domitransp/feature/services/presentation/page/service_page.dart';
import 'package:flutter/material.dart';
import 'package:domitransp/feature/web_view/pages/webview_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domitransp/feature/home/presentation/page/home_page.dart';
import 'package:domitransp/widgets/loading_animate.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../feature/consult/presentation/widgets/consult.dart';
import '../bloc/user_credential_bloc.dart';

class Body extends StatefulWidget{
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int paginaActual = 0;
  int paginaAnterior = 0;
  List pages = [];
  List<Icon> items = [
    const Icon(Icons.home, size: 30, color: Color.fromRGBO(79, 0, 148, 58),),
    const Icon(Icons.build, size: 30, color: Color.fromRGBO(79, 0, 148, 58)),
    const Icon(Icons.account_circle, size: 30, color: Color.fromRGBO(79, 0, 148, 58)),
    const Icon(Icons.location_on, size: 30, color: Color.fromRGBO(79, 0, 148, 58)),
  ];
  final screens = [
    HomePage(),
    ServicePage(),
    AccountPage(),
    AgencyPage(),
  ];
  @override
  void initState() {
    print('Hice el initstate');
    paginaAnterior = paginaActual;
    items[0] = setIcon(icono: items[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Entre al body');
    return Scaffold(
      body: BlocConsumer<UserCredentialBloc, UserCredentialState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          
          print('El estado del body es: ${state}');
          if (state is UserCredentialInProgress){
            print('Estoy en progress');
            return CustomLoadingAnimation();
          } else if (state is UserCredentialJoined){
          return Scaffold(
            body: Text('tengo usuario'),
          );
          } else {
            pages = [
              HomePage(),
              Consult(),
            ];
            return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Bottom Navigation Bar"),
            ),
            backgroundColor: Color.fromARGB(30, 230, 204, 255),
            body: screens[paginaActual],
            bottomNavigationBar: CurvedNavigationBar(items: items,
              backgroundColor: Colors.transparent, 
              buttonBackgroundColor: const Color.fromRGBO(79, 0, 148, 58),
              // color: const Color.fromRGBO(79, 0, 148, 58),

              index: paginaActual,
              onTap: (index) => setState(()
                {
                  paginaActual = index;
                  items[index] = setIcon(icono: items[index]);
                  paginaAnterior = paginaActual;
                }
              ),
            ),
          );
          }
          return HomePage();
          // return Consult();
          // return WebView();
        },
      ),
    );
  }

  Icon setIcon({required Icon icono}){
    setState(() {
      items[paginaAnterior] = Icon(items[paginaAnterior].icon, color: Color.fromRGBO(79, 0, 148, 58)  );
    });
    return Icon(icono.icon, color: Color.fromARGB(255, 244, 231, 255) );

  }
}