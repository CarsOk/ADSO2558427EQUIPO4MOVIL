import 'package:bloc/bloc.dart';
import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'user_credential_event.dart';
part 'user_credential_state.dart';

class UserCredentialBloc
    extends Bloc<UserCredentialEvent, UserCredentialState> {
  UserRepository userRepository;
  UserCredentialBloc({required this.userRepository})
      : super(UserCredentialInitial()) {
    on<AppStarted>(_mapStarted);
  }

  Future<void> _mapStarted(
      AppStarted event, Emitter<UserCredentialState> emit) async {
    print('Entre al bloc');
    emit(UserCredentialInProgress());
    final verifyToken = await userRepository.getToken();
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    try {
      if (verifyToken) {
        emit(UserCredentialJoined());
      } else {
        emit(UserUnregistered());
      }
    } catch (e) {
      print('Error en bloc user credential: ${e}');
      emit(UserUnregistered());
    }
  }
}
