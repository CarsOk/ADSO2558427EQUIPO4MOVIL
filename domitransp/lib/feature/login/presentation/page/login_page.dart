import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:domitransp/feature/login/presentation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class loginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (context) => UserRepository(),
      child: BlocProvider(create: (context) => LoginBloc(userRepository: context.read<UserRepository>()),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
          return SingleChildScrollView(
            child: Stack(children: <Widget>
              [
                
              ],
            ),
          );
        }),
      ),
    );
  
  }

}