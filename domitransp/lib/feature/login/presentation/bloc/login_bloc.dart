import 'package:bloc/bloc.dart';
import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginEnterPressed>(_mapStared);
  }

  Future<void> _mapStared(LoginEnterPressed event, Emitter<LoginState> emit) async{
    emit(LoginInProgress());
  }
}
