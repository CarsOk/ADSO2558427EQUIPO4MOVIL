part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderStarted extends OrderEvent {}
