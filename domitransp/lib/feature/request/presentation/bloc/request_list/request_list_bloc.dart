import 'package:bloc/bloc.dart';
import 'package:domitransp/feature/request/data/repository/request_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    emit(RequestListSuccess(listaPedidos: codigoList));

  }
}
