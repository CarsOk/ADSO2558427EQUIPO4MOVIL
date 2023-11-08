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
  List pages = [];
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
            backgroundColor: Color.fromARGB(49, 230, 204, 255),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 25,
                    offset: const Offset(8, 20))
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    selectedItemColor: Color.fromARGB(218, 61, 20, 99),
                    unselectedItemColor: Colors.black,
                    currentIndex: paginaActual,
                    onTap: (index) {
                      setState(() {
                        paginaActual = index;
                      });
                    },
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite), label: "Consultar"),
                    ]),
              ),
            ),
            body: pages[paginaActual],
          );
          }
          return HomePage();
          // return Consult();
          // return WebView();
        },
      ),
    );
  }}