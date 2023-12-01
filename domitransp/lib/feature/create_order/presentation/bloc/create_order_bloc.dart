import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/repository/order_dto.dart';
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
      CreateOrderEnterPressed event, Emitter<CreateOrderState> emit) async {
    emit(CreateOrderInProgress());
    try {
      bool response = await orderRepository.createOrder(orden: event.orden);

      if (response) {
        emit(CreateOrderSuccess());
      } else {
        emit(CreateOrderFailure(message: 'Hubo un error'));
      }
    } catch (e) {
      if (e is OrderError) {
        emit(CreateOrderFailure(message: e.message));
      }
    }
  }
}
