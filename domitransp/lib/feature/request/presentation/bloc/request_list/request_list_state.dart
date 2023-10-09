part of 'request_list_bloc.dart';

abstract class RequestListState {}

class RequestListInProgress extends RequestListState {}

class RequestListSuccess extends RequestListState {
  List<RequestListDto> listaPedidos;

  RequestListSuccess({required this.listaPedidos});
}

class RequestListFailure extends RequestListState {
  String message;

  RequestListFailure({required this.message});
}

class RequestListEmpty extends RequestListState {}
