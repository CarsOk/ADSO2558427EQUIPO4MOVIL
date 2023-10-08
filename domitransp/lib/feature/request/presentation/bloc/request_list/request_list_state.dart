part of 'request_list_bloc.dart';

abstract class RequestListState {}

class RequestListInProgress extends RequestListState {}

class RequestListSuccess extends RequestListState {
  List<String> listaPedidos;

  RequestListSuccess({required this.listaPedidos});
}

class RequestListFailure extends RequestListState {}
