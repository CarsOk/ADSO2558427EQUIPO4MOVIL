import 'package:carousel_slider/carousel_slider.dart';
import 'package:domitransp/feature/home/data/respository/home_repository.dart';
import 'package:domitransp/feature/home/presentation/bloc/home_bloc.dart';
import 'package:domitransp/feature/home/presentation/widget/category_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../routes/routes.dart';
import '../../../global/color_app.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _current = 0;

  List<String> imageList = [
    'assets/picture/imagen/publactionNoInternet.png',
    'assets/picture/imagen/publactionNoInternet.png',
    'assets/picture/imagen/publactionNoInternet.png',
    'assets/picture/imagen/publactionNoInternet.png',
  ];

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: SingleChildScrollView(
        child: BlocProvider(
          create: (context) =>
              HomeBloc(homeRepository: context.read<HomeRepository>())
                ..add(HomeStarted()),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeSucess) {
                    print('El home es success');
                    return Column(children: <Widget>[
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                              // print('el index es: $index');
                            });
                          },
                        ),
                        items: state.publications
                            .map((publication) => Container(
                                  child: Center(
                                    child: Image.network(
                                      publication.url,
                                      fit: BoxFit.cover,
                                      width: 1000,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          int index = entry.key;
                          String url = entry.value;
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(61, 19, 97, 38)
                                  : Colors.grey,
                            ),
                          );
                        }).toList(),
                      ),
                    ]);
                  } else if (state is HomeFailure) {
                    print('El home es failure');
                    return Column(children: <Widget>[
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                              // print('el index es: $index');
                            });
                          },
                        ),
                        items: imageList
                            .map((item) => Container(
                                  child: Center(
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.cover,
                                      width: 1000,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          int index = entry.key;
                          String url = entry.value;
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == index
                                  ? Color.fromRGBO(61, 19, 97, 38)
                                  : Colors.grey,
                            ),
                          );
                        }).toList(),
                      ),
                    ]);
                  } else if (state is HomeLoading) {
                    return Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'consult');
                      },
                      child: Image.asset(
                        'assets/picture/boton/botonConsultarEnvios.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'list_request');
                      },
                      child: Image.asset(
                        'assets/picture/boton/botonContacto.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  GestureDetector? gesture;
  Function()? onTap;

  CategoryButton({
    required this.color,
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 48.0,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryIconWidget(
                    icono: Icons.add, onTap: () {}, nombre: 'giros nacionales'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
