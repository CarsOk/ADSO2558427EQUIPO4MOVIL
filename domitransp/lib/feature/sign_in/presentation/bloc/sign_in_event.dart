part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInEnterPressed extends SignInEvent {
  String email;

  SignInEnterPressed({required this.email});
}
