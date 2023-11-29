import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  UserRepository userRespository;
  SignInBloc({required this.userRespository}) : super(SignInInitial()) {
    on<SignInEnterPressed>(_mapStared);
  }

  Future<void> _mapStared(
      SignInEnterPressed event, Emitter<SignInState> emit) async {
    emit(SignInProgress());
    try {
      bool response = await userRespository.userSignIn(email: event.email);

      if (response) {
        emit(SignInSuccess());
      } else {
        emit(
          SignInFailure(message: ''),
        );
      }
    } catch (e) {
      if (e is UserError) {
        emit(SignInFailure(message: e.message));
      }
    }
  }
}
