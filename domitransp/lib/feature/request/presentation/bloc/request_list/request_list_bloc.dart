import 'package:bloc/bloc.dart';
import 'package:domitransp/feature/request/data/repository/request_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/repository/request_list_dto.dart';

part 'request_list_event.dart';
part 'request_list_state.dart';

class RequestListBloc extends Bloc<RequestListEvent, RequestListState> {
  final RequestRepository requestRepository;
  
  RequestListBloc({required this.requestRepository}) : super(RequestListInProgress()) {
    on<RequestListStarted>(_mapEnter);
  }

  Future<void> _mapEnter(RequestListStarted event, Emitter<RequestListState> emit) async {
    emit(RequestListInProgress());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> codigoList = await prefs.getStringList('codigoList') ?? [];
    print('Entre al bloc');
    print('Esta es la lista de codigoList en bloc: $codigoList y su tipo es ${codigoList.runtimeType}');
    
    try {
      print('Entre al try');
      if (codigoList.isNotEmpty){
        final lista = await requestRepository.validationCode(prefs: prefs, codigos: codigoList);
      emit(RequestListSuccess(listaPedidos: lista));
      } else {
        emit(RequestListEmpty());
        print('Esta vacio la listas');
      }
    } catch (e) {
      print('Falle en el bloc de request lis: $e y el tipo es ${e.runtimeType}');
      if(e is NoConection){
        emit(RequestListFailure(message: e.message));
        print('Falle en el bloc de request lis: $e y el tipo es ${e.runtimeType}');
      }else{
        emit(RequestListFailure(message: 'Error'));
        print('Falle en el bloc de request lis: $e y el tipo es ${e.runtimeType}');

      }
    }
    print('Estoy fuera del try');
      
    
    


  }
}
