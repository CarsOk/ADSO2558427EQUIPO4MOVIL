part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderState {}

class CreateOrderInitial extends CreateOrderState {}

class CreateOrderInProgress extends CreateOrderState {}

class CreateOrderSuccess extends CreateOrderState {}

class CreateOrderFailure extends CreateOrderState {
  String message;

  CreateOrderFailure({required this.message});
}
