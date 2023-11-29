part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInProgress extends SignInState {}

class SignInSuccess extends SignInState {}

// ignore: must_be_immutable
class SignInFailure extends SignInState {
  String message;

  SignInFailure({required this.message});
}
