import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/order_repository.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent, CreateOrderState> {
  OrderRepository orderRepository;
  CreateOrderBloc({required this.orderRepository})
      : super(CreateOrderInitial()) {
    on<CreateOrderEnterPressed>(_mapStarted);
  }

  Future<void> _mapStarted(
      CreateOrderEnterPressed event, Emitter<CreateOrderState> emit) async {}
}
