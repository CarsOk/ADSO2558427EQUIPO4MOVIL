part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountUnauthentication extends AccountState {}

class AccounAuthentication extends AccountState {}

class AccountInProgress extends AccountState {}

class AccountExitInProgress extends AccountState {}

// ignore: must_be_immutable
class AccountSuccess extends AccountState {
  UserDto user;

  AccountSuccess({required this.user});
}

// ignore: must_be_immutable
class AccountFailure extends AccountState {
  String message;

  AccountFailure({required this.message});
}
