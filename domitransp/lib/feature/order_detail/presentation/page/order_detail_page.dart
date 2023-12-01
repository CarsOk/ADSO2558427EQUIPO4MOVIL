import 'package:flutter/material.dart';

import '../../../../core/data/repository/list_order_dto.dart';
import '../../../global/color_app.dart';
import '../../../global/fonts.dart';

class OrderDetailPage extends StatelessWidget {
  ListOrderDto orden;
  OrderDetailPage({super.key, required this.orden});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        leadingWidth: 60.0,
        // bottom: ,
        title: Text(
          'Orden ${orden.consecutivo}',
          style: Fonts.subtitle(),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: ColorApp.decorador(),
      ),
      backgroundColor: ColorApp.fondo(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  orden.avatarUrl!,
                  width: 200.0,
                  // height: 200.0,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/picture/imagen/publactionNoInternet.png',
                      width: 200.0,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              // height: 100,
              decoration: BoxDecoration(
                color: ColorApp.decorador(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Concecutivo',
                      style: Fonts.title(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orden.consecutivo!.toString(),
                      style: Fonts.personalizado(
                          sizeFont: 16.0, weight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Text(
                      'Estado',
                      style: Fonts.title(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orden.estado!,
                      style: Fonts.personalizado(
                          sizeFont: 16.0, weight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Origen',
                      style: Fonts.title(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orden.origen!,
                      style: Fonts.personalizado(
                          sizeFont: 16.0, weight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Destino',
                      style: Fonts.title(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orden.destino!,
                      style: Fonts.personalizado(
                          sizeFont: 16.0, weight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Código de envio',
                      style: Fonts.title(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orden.codigoEnvio!,
                      style: Fonts.personalizado(
                          sizeFont: 16.0, weight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Valor',
                      style: Fonts.title(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      orden.valor!.toString(),
                      style: Fonts.personalizado(
                          sizeFont: 16.0, weight: FontWeight.w300),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
