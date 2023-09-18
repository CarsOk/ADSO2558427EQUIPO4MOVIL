part of 'consult_bloc.dart';

@immutable
abstract class ConsultEvent {}

class ConsultEnterPressed extends ConsultEvent {
  final codigo;

  ConsultEnterPressed({this.codigo});
}
