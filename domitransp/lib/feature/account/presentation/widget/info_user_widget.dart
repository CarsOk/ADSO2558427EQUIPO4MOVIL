import 'package:domitransp/feature/account/presentation/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/repository/user_repository.dart';
import '../../../../core/presentation/bloc/user_credential_bloc.dart';
import '../../../../widgets/circular_animate_widget.dart';
import '../../../global/fonts.dart';
import 'profile_image_widget.dart';

class InfoUserWidget extends StatelessWidget {
  double alturaStack = 200.0;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) =>
            AccountBloc(userRepository: context.read<UserRepository>())
              ..add(AccountStarted()),
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountUnauthentication) {
              Navigator.popUntil(context, ModalRoute.withName('body'));
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            SizedBox(
                              width: double.infinity,
                              height: alturaStack,
                              child: ClipRect(
                                child: Image.asset(
                                  'assets/picture/fondo/fondoUsuario.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            BlocBuilder<AccountBloc, AccountState>(
                              builder: (context, state) {
                                if (state is AccountSuccess) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: alturaStack,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ProfileImageWidget(
                                            image: state.user.avatar),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(state.user.nombre,
                                            style: Fonts.titleThin())
                                      ],
                                    ),
                                  );
                                }
                                if (state is AccountFailure) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: alturaStack,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ProfileImageWidget(image: null),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text('Nickname',
                                            style: Fonts.titleThin())
                                      ],
                                    ),
                                  );
                                } else {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: alturaStack,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
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
                                  'assets/picture/boton/botonsEnvios_1.png',
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  AccountBloc(
                                          userRepository:
                                              context.read<UserRepository>())
                                      .add(AccountSignOut());
                                },
                                child: Image.asset(
                                  'assets/picture/boton/botonSalir.png',
                                  // fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (state is AccountExitInProgress) CircularAnimateWidget()
              ],
            );
          },
        ),
      ),
    );
  }
}
