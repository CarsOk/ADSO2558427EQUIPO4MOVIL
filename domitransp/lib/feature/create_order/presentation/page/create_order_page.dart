import 'package:domitransp/feature/global/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../global/fonts.dart';
import '../../data/repository/order_repository.dart';
import '../bloc/create_order_bloc.dart';

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(
            'Asi se ve la imagen al ser enviada: ${_image} y es tipo ${_image.runtimeType}');
      }
    });
  }

  // Future<void> _uploadImage() async {
  //   // Aquí deberías implementar la lógica para enviar la imagen a tu API
  //   // Utiliza la biblioteca Dio para hacer la solicitud HTTP.

  //   // Ejemplo:
  //   Dio dio = Dio();
  //   FormData formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(_image!.path),
  //   });
  //   // FormData imagen = await MultipartFile.fromFile(_image!.path);
  //   // Response response = await dio.post('TU_API_ENDPOINT', data: formData);

  //   // // Maneja la respuesta de la API aquí
  //   // print(response.data);
  // }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OrderRepository(),
      child: BlocProvider(
        create: (context) =>
            CreateOrderBloc(orderRepository: context.read<OrderRepository>()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Crea tu pedido',
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
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 2.0, bottom: 2.0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fecha de orden',
                          style: Fonts.text2(),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 2),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorApp.decorador(),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: FormBuilderDateTimePicker(
                            name: 'date',
                            style: Fonts.personalizado(sizeFont: 14.0),
                            inputType: InputType.date,
                            format: DateFormat('dd-MM-yyyy'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (DateTime? value) {
                              if (value == null) {
                                return 'Selecciona una fecha';
                              }

                              final now = DateTime.now();
                              final minDate = now.add(Duration(days: 5));
                              final maxDate =
                                  now.add(Duration(days: 730)); // 2 años

                              if (value.isBefore(minDate) ||
                                  value.isAfter(maxDate)) {
                                return 'La fecha debe estar entre 5 días después de hoy y 2 años desde hoy';
                              }

                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 4),
                        _image != null
                            ? Container(
                                width: 200,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Text('Selecciona una imagen'),
                        ElevatedButton(
                          onPressed: _getImage,
                          child: Text('Seleccionar Imagen'),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Subir Imagen'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
