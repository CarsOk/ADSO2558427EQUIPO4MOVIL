import 'package:domitransp/feature/global/color_app.dart';
import 'package:domitransp/feature/opt/presentation/page/opt_page.dart';
import 'package:domitransp/feature/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:domitransp/widgets/loading_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/user_repository.dart';
import '../../../validator/validator.dart';

final _formkey = GlobalKey<FormState>();

// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  SignInPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => UserRepository(),
        child: BlocProvider(
          create: (context) => SignInBloc(
            userRespository: context.read<UserRepository>(),
          ),
          child: BlocConsumer<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInProgress) {
                return CustomLoadingAnimation();
              }
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'assets/picture/fondo/fondo-inicio.png',
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(
                            'assets/picture/logo/logoEmpresaSinNombre.png',
                            width: 250.0,
                          ),
                          const SizedBox(height: 10.0),
                          Image.asset(
                            'assets/picture/logo/nombreEmpresa.png',
                            width: 250.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: emailController,
                                validator: Validator.email,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(197, 71, 15, 121),
                                  hintText: 'Ingresar correo electrónico',
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 50.0,
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      context.read<SignInBloc>().add(
                                          SignInEnterPressed(
                                              email: emailController.text));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    // ignore: deprecated_member_use
                                    primary: ColorApp.calidoAnalogo(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(250, 249, 249, 0.89),
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is SignInProgress) CustomLoadingAnimation(),
                ],
              );
            },
            listener: (context, state) {
              if (state is SignInSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OptPage(email: emailController.text),
                  ),
                );
              } else if (state is SignInFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
