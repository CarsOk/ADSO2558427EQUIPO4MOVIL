import 'package:domitransp/core/data/repository/list_order_dto.dart';
import 'package:domitransp/feature/create_order/data/repository/order_repository.dart';
import 'package:domitransp/feature/order_detail/presentation/page/order_detail_page.dart';
import 'package:domitransp/widgets/general_animate_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/color_app.dart';
import '../../../global/fonts.dart';
import '../bloc/order_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        leadingWidth: 60.0,
        title: Text(
          'Mis ordenes',
          style: Fonts.subtitle(),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: ColorApp.decorador(),
      ),
      backgroundColor: ColorApp.fondo(),
      body: RepositoryProvider(
        create: (context) => OrderRepository(),
        child: BlocProvider(
          create: (context) => OrderBloc(
            orderRepository: context.read<OrderRepository>(),
          )..add(OrderStarted()),
          child: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              print('el estado es $state');
              if (state is OrderInProgress) {
                return GeneralAnimateLoading();
              } else if (state is OrderSuccess) {
                return ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    ListOrderDto orden = state.orders[index];
                    return Card(
                      color: ColorApp.decorador(),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderDetailPage(
                                orden: orden,
                              ),
                            ),
                          );
                        },
                        leading: icono(estado: orden.estado!),
                        title: Text(orden.consecutivo!.toString(),
                            style: Fonts.subtitle()),
                        subtitle: Text('Estado: ${orden.estado}',
                            style: Fonts.personalizado(
                                sizeFont: 12.0, weight: FontWeight.w500)),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ColorApp.blanco(),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Stack(children: <Widget>[
                  Column(
                    children: <Widget>[Text('falle')],
                  )
                ]);
              }
            },
          ),
        ),
      ),
      // body: ,
    );
  }

  Widget icono({required String estado}) {
    if (estado == "Aceptado") {
      return Icon(Icons.check, size: 40, color: ColorApp.blanco());
    } else if (estado == "Recogido") {
      return Icon(Icons.shopping_bag, size: 40, color: ColorApp.blanco());
    } else if (estado == "En camino") {
      return Icon(Icons.directions_run, size: 40, color: ColorApp.blanco());
    } else if (estado == "En camino") {
      return Icon(Icons.motorcycle, size: 40, color: ColorApp.blanco());
    } else if (estado == "En espera") {
      return Icon(Icons.hourglass_empty, size: 40, color: ColorApp.blanco());
    } else {
      print('el estado es ${estado}');
      return Icon(Icons.done, size: 40, color: ColorApp.blanco());
    }
  }
}
