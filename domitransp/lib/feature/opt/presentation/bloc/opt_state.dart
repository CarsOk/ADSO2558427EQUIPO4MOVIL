part of 'opt_bloc.dart';

@immutable
abstract class OptState {}

class OptInitial extends OptState {}

class OptInProgress extends OptState {}

class OptSuccess extends OptState {}

class OptFailure extends OptState {
  String message;

  OptFailure({required this.message});
}
