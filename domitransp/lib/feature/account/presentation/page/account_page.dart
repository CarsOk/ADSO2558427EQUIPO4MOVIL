import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:domitransp/core/presentation/bloc/user_credential_bloc.dart';
import 'package:domitransp/feature/account/presentation/widget/unregistered_widget.dart';
import 'package:domitransp/widgets/general_animate_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../widgets/circular_animate_widget.dart';
import '../../../global/fonts.dart';
import '../bloc/account_bloc.dart';
import '../widget/info_user_widget.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserCredentialBloc(userRepository: context.read<UserRepository>())
                ..add(AppStarted()),
        ),
      ],
      child: BlocBuilder<UserCredentialBloc, UserCredentialState>(
          builder: (context, state) {
        print('El estado es $state');
        if (state is UserUnregistered) {
          return UnregisteredWidget();
        } else if (state is UserCredentialInProgress) {
          // return GeneralAnimateLoading();
          // return CircularAnimateWidget();
          return CircularAnimateWidget();
        } else if (state is UserCredentialJoined) {
          return InfoUserWidget();
        }
        return Container();
      }),
    );
  }
}
