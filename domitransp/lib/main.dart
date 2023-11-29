import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:domitransp/core/presentation/bloc/user_credential_bloc.dart';
import 'package:domitransp/feature/opt/presentation/page/opt_page.dart';
import 'package:domitransp/feature/sign_in/presentation/page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domitransp/routes/routes.dart';
import 'core/presentation/widgets/body.dart';
import 'feature/create_order/presentation/page/create_order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Entre al main');
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) =>
            UserCredentialBloc(userRepository: context.read<UserRepository>())
              ..add(AppStarted()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Domitransp',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: CreateOrderPage(),
          // home: Body(),
          // home: OptPage(email: 'hola@gmail.com'),
          routes: routes,
        ),
      ),
    );
  }
}
