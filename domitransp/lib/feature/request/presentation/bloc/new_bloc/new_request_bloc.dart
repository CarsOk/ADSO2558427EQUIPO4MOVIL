import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:domitransp/feature/request/data/repository/request_repository.dart';

part 'new_request_event.dart';
part 'new_request_state.dart';

class NewRequestBloc extends Bloc<NewRequestEvent, NewRequestState> {
  final RequestRepository requestRepository; 
  final uuid = Uuid();

  NewRequestBloc({required this.requestRepository}) : super(NewRequestInitial()) {
    on<NewRequestEnterPressed>(_mapEnter);
      // TODO: implement event handler
  }
  Future<void> _mapEnter(NewRequestEnterPressed event, Emitter<NewRequestState> emit) async {
    emit(NewRequestInProgress());

    try {
      
      String codigoRequest = uuid.v4();
      print('Este es el uuid numero unico $uuid');
      bool insercion = await requestRepository.insertRequest(email: event.email, name: event.name, title: event.title, subject: event.subject, code: codigoRequest);
      if(insercion){
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> codigoList = prefs.getStringList('codigoList') ?? [];
        codigoList.add(codigoRequest);
        await prefs.setStringList('codigoList', codigoList);

        List<String>? listaactual = prefs.getStringList('codigoList');
        print('lista actual: ${listaactual}');
        emit(NewRequestInSuccess());
        } catch (e) {
          print('Falle apunto de de instertar');
          print(e);
          emit(NewRequestInFailure(message: 'Erroren el envio'));
        }
        
      }else{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        emit(NewRequestInFailure(message: 'Error de conexion'));
      }
    } catch (e) {
      print("fallo en bloc de request");
      emit(NewRequestInFailure(message: 'Error de conexion'));
    }

  }
  
}
