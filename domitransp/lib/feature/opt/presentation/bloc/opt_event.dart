part of 'opt_bloc.dart';

@immutable
abstract class OptEvent {}

class OptEnterPressed extends OptEvent {
  String email;
  String code;

  OptEnterPressed({required this.code, required this.email});
}
