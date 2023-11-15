part of 'new_request_bloc.dart';

@immutable
abstract class NewRequestState {}

class NewRequestInitial extends NewRequestState {}

class NewRequestInProgress extends NewRequestState {}

class NewRequestInSuccess extends NewRequestState {}

class NewRequestInFailure extends NewRequestState {
  final String message;

  NewRequestInFailure({required this.message});
}
