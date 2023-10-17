import 'package:bloc/bloc.dart';
import 'package:domitransp/feature/request/data/repository/request_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../core/data/repository/chat_dto.dart';
import '../../../../../core/data/repository/request_list_dto.dart';

part 'request_chat_event.dart';
part 'request_chat_state.dart';

class RequestChatBloc extends Bloc<RequestChatEvent, RequestChatState> {

  final RequestRepository requestRepository;
  
  RequestChatBloc({required this.requestRepository}) : super(RequestChatInitial()) {
    on<RequestChatStarted>(_mapEnter);
    on<SendResponseEnterPressed>(_mapSend);
    on<RefreshRequestEnterPressed>(_refresh);
  }

  Future<void> _mapSend(SendResponseEnterPressed event, Emitter<RequestChatState> emit) async{
    print("Entre al bloc de envio de mensaje");
    try {
      requestRepository.sendResponse(idRequest: event.requestDto.id, message: event.content);
      
    } catch (e) {
      if(e is NoConection){
        emit(RequestChatFailure(message: e.message));
      }else{
        emit(RequestChatFailure(message: 'Ha ocurrido un error inesperado'));
      }
      
    }
  }

  Future<void> _mapEnter(RequestChatStarted event, Emitter<RequestChatState> emit) async{
    print('Entre al bloc RequestChatBloc');
    emit(RequestChatInProgress());
 
    try {
      if (event.requestDto.estado == 'Closed'){
        emit(RequestChatClose());
      } else {
        final chatList = await requestRepository.getChat(idRequest: event.requestDto.id);
        print('En el bloc, esto es lo que trae chatList: $chatList');
        emit(RequestChatSuccess(chatList: chatList));
      }
    } catch (e) {
      print('Falle en el RequestRepositroy bloc: $e');
      if (e is ResponseEmpty){
        emit(RequestChatFailure(message: e.message));
      }else if(e is NoConection){
        emit(RequestChatFailure(message: e.message));
      } else{
        emit(RequestChatFailure(message: 'Ha ocurrido un error inesperado'));
      }
    }
  } 

  Future<void> _refresh(RefreshRequestEnterPressed event, Emitter<RequestChatState> emit) async{
    print('Estoy ejecutando refresh');
    try {
      if (event.requestDto.estado == 'Closed'){
        emit(RequestChatClose());
      } else {
        final chatList = await requestRepository.getChat(idRequest: event.requestDto.id);
        print('En el bloc, esto es lo que trae chatList: $chatList');
        emit(RequestChatSuccess(chatList: chatList));
      }
    } catch (e) {
      print('Falle en el RequestRepositroy bloc: $e');
      if (e is ResponseEmpty){
        emit(RequestChatFailure(message: e.message));
      }else if(e is NoConection){
        emit(RequestChatFailure(message: e.message));
      } else{
        emit(RequestChatFailure(message: 'Ha ocurrido un error inesperado'));
      }
    }
  } 
}
