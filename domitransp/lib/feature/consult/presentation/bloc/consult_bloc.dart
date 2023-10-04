import 'package:bloc/bloc.dart';
import 'package:domitransp/feature/consult/data/repository/consult_repository.dart';
import 'package:domitransp/widgets/loading_animate.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/repository/consult_dto.dart';

part 'consult_event.dart';
part 'consult_state.dart';

class ConsultBloc extends Bloc<ConsultEvent, ConsultState> {

  final ConsultRepository consultRepository;

  ConsultBloc({required this.consultRepository}) : super(ConsultInitial()){
    on<ConsultEnterPressed>(_mapStared);
  }

  Future<void> _mapStared(
    ConsultEnterPressed event, Emitter<ConsultState> emit) async {
      emit((ConsultInProgress()));

      try {
        final consulta = await consultRepository.buscarRegistro(event.codigo);

        emit(ConsultLoadSuccess(consultaDto: consulta));
      } catch (e) {
        print("Chale, fallé en el envío del código");
        print(e);
        if(e is Nocode){
          emit(ConsultLoadFailure(message: e.message));
        }
      }
  }

}
