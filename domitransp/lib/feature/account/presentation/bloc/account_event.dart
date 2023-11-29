part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class AccountStarted extends AccountEvent {}

class AccountSignOut extends AccountEvent {}
