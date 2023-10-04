
part of 'consult_bloc.dart';

@immutable
abstract class ConsultState {}

class ConsultInitial extends ConsultState {}

class ConsultInProgress extends ConsultState {}

class ConsultLoadSuccess extends ConsultState {
  final consultaDto;

  ConsultLoadSuccess({required this.consultaDto});
}

class ConsultLoadFailure extends ConsultState {
  String message;

  ConsultLoadFailure({required this.message});
}