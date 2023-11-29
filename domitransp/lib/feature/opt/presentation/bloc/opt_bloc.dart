import 'package:bloc/bloc.dart';
import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'opt_event.dart';
part 'opt_state.dart';

class OptBloc extends Bloc<OptEvent, OptState> {
  UserRepository userRepository;
  OptBloc({required this.userRepository}) : super(OptInitial()) {
    on<OptEnterPressed>(_mapStared);
  }

  Future<void> _mapStared(OptEnterPressed event, Emitter<OptState> emit) async {
    emit(OptInProgress());
    try {
      bool response = await userRepository.confirmarUser(
          code: event.code, email: event.email);
      if (response) {
        emit(OptSuccess());
      }
    } catch (e) {
      if (e is UserError) {
        emit(OptFailure(message: e.message));
      }
    }
  }
}
