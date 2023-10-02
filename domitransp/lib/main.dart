import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domitransp/routes/routes.dart';

import 'package:domitransp/core/presentation/bloc/home_bloc.dart';
import 'package:domitransp/core/data/repository/home_repository.dart';
import 'core/presentation/widgets/body.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: BlocProvider(
        create: (context) => HomeBloc(homeRepository: context.read<HomeRepository>())
        ..add(HomeStarted()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Domitransp',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: Body(),
          routes: routes,
        ),
      ),
    );
  }
}