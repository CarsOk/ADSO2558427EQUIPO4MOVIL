import 'package:bloc/bloc.dart';
import 'package:domitransp/core/data/repository/list_order_dto.dart';
import 'package:domitransp/core/data/repository/user_repository.dart';
import 'package:domitransp/feature/create_order/data/repository/order_repository.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderRepository orderRepository;
  OrderBloc({required this.orderRepository}) : super(OrderInitial()) {
    on<OrderStarted>(_mapStarted);
  }

  Future<void> _mapStarted(OrderStarted event, Emitter<OrderState> emit) async {
    emit(OrderInProgress());
    try {
      final response = await orderRepository.getOrders();

      emit(OrderSuccess(orders: response));
    } catch (e) {
      if (e is OrderError) {
        emit(OrderFailure(message: e.message));
      }
    }
  }
}
