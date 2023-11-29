import 'package:bloc/bloc.dart';
import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/repository/user_dto.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  UserRepository userRepository;
  AccountBloc({required this.userRepository}) : super(AccountInitial()) {
    on<AccountStarted>(_mapStared);
    on<AccountSignOut>(_mapEnd);
  }

  Future<void> _mapStared(
      AccountStarted event, Emitter<AccountState> emit) async {
    try {
      emit(AccountInProgress());

      UserDto user = await userRepository.getUser();

      emit(AccountSuccess(user: user));
    } catch (e) {
      if (e is UserError) {
        emit(AccountFailure(message: e.message));
      }
    }
  }

  Future<void> _mapEnd(AccountSignOut event, Emitter<AccountState> emit) async {
    try {
      emit(AccountExitInProgress());
      final killToken = await userRepository.deleteUser();

      if (killToken) {
        emit(AccountUnauthentication());
      }
    } catch (e) {
      if (e is UserError) {
        emit(AccountFailure(message: e.message));
      }
    }
  }
}
