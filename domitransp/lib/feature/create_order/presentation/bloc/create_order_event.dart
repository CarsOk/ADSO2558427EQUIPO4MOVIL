part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderEvent {}

class CreateOrderEnterPressed extends CreateOrderEvent {}