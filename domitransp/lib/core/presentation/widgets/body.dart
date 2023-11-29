import 'dart:async';
// import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:domitransp/feature/account/presentation/page/account_page.dart';
import 'package:domitransp/feature/agency/presentation/page/agency_page.dart';
import 'package:domitransp/feature/services/presentation/page/service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domitransp/feature/home/presentation/page/home_page.dart';
import '../../../feature/consult/presentation/widgets/consult.dart';
import '../../../feature/global/color_app.dart';
import '../../../widgets/general_animate_loading.dart';
import '../../../widgets/round_app_bar.dart';
import '../bloc/user_credential_bloc.dart';
import 'icono_degradado_widget.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int paginaActual = 0;
  int paginaAnterior = 0;
  List pages = [];
  List<IconoDegradadoWidget> items = [
    IconoDegradadoWidget(icono: Icons.home_outlined),
    IconoDegradadoWidget(icono: Icons.build_outlined),
    IconoDegradadoWidget(icono: Icons.account_circle_outlined),
    IconoDegradadoWidget(icono: Icons.location_on_outlined),
  ];
  final screens = [
    HomePage(),
    ServicePage(),
    AccountPage(),
    AgencyPage(),
  ];
  // ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    // _checkConnectivity();
    items[0] = IconoDegradadoWidget(icono: Icons.home_outlined, activo: true);

    // Timer.periodic(Duration(seconds: 20), (Timer timer) {
    // _checkConnectivity();
    // });
  }

  Future<void> _checkConnectivity() async {
    // final result = await Connectivity().checkConnectivity();
    setState(() {
      // _connectivityResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCredentialBloc, UserCredentialState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is UserCredentialInProgress) {
          return GeneralAnimateLoading();
        }
        return Scaffold(
          appBar: AppBarRedondo(),
          backgroundColor: ColorApp.fondo(),
          body:
              //  _connectivityResult == ConnectivityResult.none ? _buildNoConnectivityWidget() :
              SingleChildScrollView(child: screens[paginaActual]),
          bottomNavigationBar: CurvedNavigationBar(
            items: items,
            color: ColorApp.decorador(),
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: ColorApp.decorador(),
            index: paginaActual,
            onTap: (index) => setState(() {
              // if (_connectivityResult != ConnectivityResult.none) {
              paginaActual = index;
              items[index] = setIcon(icono: items[index]);
              paginaAnterior = paginaActual;
              // } else {
              //   // Mostrar mensaje de no conexión o realizar alguna acción alternativa
              //   print('No hay conexión a Internet');
              // }
            }),
          ),
        );
      },
    );
  }

  Widget _buildNoConnectivityWidget() {
    return Center(
      child: Text(
        'No hay conexión a Internet',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  IconoDegradadoWidget setIcon({required IconoDegradadoWidget icono}) {
    setState(() {
      items[paginaAnterior] = IconoDegradadoWidget(
        icono: items[paginaAnterior].icono,
      );
    });
    return IconoDegradadoWidget(
      icono: icono.icono,
      activo: true,
    );
  }
}
