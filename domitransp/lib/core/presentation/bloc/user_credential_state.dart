part of 'user_credential_bloc.dart';

@immutable
abstract class UserCredentialState {}

class UserCredentialInitial extends UserCredentialState {}

class UserCredentialInProgress extends UserCredentialState {}

class UserCredentialJoined extends UserCredentialState {}

class UserUnregistered extends UserCredentialState {}
