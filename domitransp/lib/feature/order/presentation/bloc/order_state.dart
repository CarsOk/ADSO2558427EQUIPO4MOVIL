part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderInProgress extends OrderState {}

class OrderSuccess extends OrderState {
  List orders;

  OrderSuccess({required this.orders});
}

class OrderFailure extends OrderState {
  String message;

  OrderFailure({required this.message});
}
