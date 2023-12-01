import 'dart:convert';

import 'package:domitransp/feature/global/color_app.dart';
import 'package:domitransp/feature/validator/validator.dart';
import 'package:domitransp/widgets/create_order_animate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/repository/order_dto.dart';
import '../../../global/fonts.dart';
import '../../data/repository/order_repository.dart';
import '../bloc/create_order_bloc.dart';

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  TextEditingController consecutivoController = TextEditingController();

  TextEditingController paqueteController = TextEditingController();
  TextEditingController sobreController = TextEditingController();
  TextEditingController cavaController = TextEditingController();
  TextEditingController cajaController = TextEditingController();
  TextEditingController maletaController = TextEditingController();
  TextEditingController contenedorController = TextEditingController();
  late String? fecha;

  late OrderDto orden;
  late ImagePicker picker;
  late PickedFile? pickedFile;
  late String base64Image = '';
  File? image;
  List<String> ciudades = [
    'Barranquilla',
    'Sincelejo',
    'Cartagena',
    'Santa marta',
    'Valledupar',
    'Monteria',
  ];
  String? ciudadOrigen;
  String? ciudadDestino;
  @override
  void initState() {
    super.initState();
    ciudadOrigen = ciudades[0]; // Inicializar en initState
    ciudadDestino = ciudades[0];
  }

  Future<void> _getImage() async {
    picker = ImagePicker();
    pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile!.path);
      }
    });

    // Convertir la imagen a JSON
  }

  // Future<void> _uploadImage() async {
  //   // Aquí deberías implementar la lógica para enviar la imagen a tu API
  //   // Utiliza la biblioteca Dio para hacer la solicitud HTTP.

  //   // Ejemplo:
  //   Dio dio = Dio();
  //   FormData formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(image!.path),
  //   });
  //   // FormData imagen = await MultipartFile.fromFile(image!.path);
  //   // Response response = await dio.post('TU_API_ENDPOINT', data: formData);

  //   // // Maneja la respuesta de la API aquí
  //   // print(response.data);
  // }

  @override
  Widget build(BuildContext context) {
    // paqueteController.text = '0';
    // sobreController.text = '0';
    // cavaController.text = '0';
    // cajaController.text = '0';
    // maletaController.text = '0';
    // contenedorController.text = '0';
    return RepositoryProvider(
      create: (context) => OrderRepository(),
      child: BlocProvider(
        create: (context) =>
            CreateOrderBloc(orderRepository: context.read<OrderRepository>()),
        child: BlocConsumer<CreateOrderBloc, CreateOrderState>(
          listener: (context, state) {
            if (state is CreateOrderFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is CreateOrderSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Se creo la orden correctamente'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60.0,
                leadingWidth: 60.0,
                // bottom: ,
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
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 8.0, bottom: 2.0),
                      child: FormBuilder(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              'Fecha de orden',
                              style: Fonts.text2(),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 4.0),
                            FormBuilderDateTimePicker(
                              name: 'date',
                              // controller: fechaController,
                              style: Fonts.personalizado(sizeFont: 14.0),
                              inputType: InputType.date,
                              format: DateFormat('dd-MM-yyyy'),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (DateTime? value) => inputFecha(value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorApp.decorador(),
                                // hintText: 'Fecha',
                                prefixIcon: const Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Digitar consecutivo',
                              style: Fonts.text2(),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: consecutivoController,
                              validator: Validator.consecutivo,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorApp.decorador(),
                                hintText: 'Ej: 12345',
                                prefixIcon: const Icon(
                                  Icons.format_list_numbered,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintStyle: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Tipo de orden',
                              style: Fonts.subtitle(),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: ColorApp.decorador(),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text('Paquete', style: Fonts.text3()),
                                      const SizedBox(height: 8),
                                      Icon(Icons.archive,
                                          size: 60, color: ColorApp.blanco()),
                                    ]),
                                    SizedBox(
                                      width: 150,
                                      // height: 40,
                                      child: TextFormField(
                                        controller: paqueteController,
                                        validator: Validator.tipoPaquete,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        style:
                                            Fonts.personalizado(sizeFont: 18.0),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorApp.decorador(),
                                          hintText: '0',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintStyle: Fonts.subtitle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: ColorApp.decorador(),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text('Sobre', style: Fonts.text3()),
                                      const SizedBox(height: 8),
                                      Icon(Icons.mail,
                                          size: 60, color: ColorApp.blanco()),
                                    ]),
                                    SizedBox(
                                      width: 150,
                                      // height: 0,
                                      child: TextFormField(
                                        controller: sobreController,
                                        validator: Validator.tipoPaquete,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        style:
                                            Fonts.personalizado(sizeFont: 18.0),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorApp.decorador(),
                                          hintText: '0',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintStyle: Fonts.subtitle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: ColorApp.decorador(),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text('Maleta', style: Fonts.text3()),
                                      const SizedBox(height: 8),
                                      Icon(Icons.card_travel,
                                          size: 60, color: ColorApp.blanco()),
                                    ]),
                                    SizedBox(
                                      width: 150,
                                      // height: 0,
                                      child: TextFormField(
                                        controller: maletaController,
                                        validator: Validator.tipoPaquete,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        style:
                                            Fonts.personalizado(sizeFont: 18.0),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorApp.decorador(),
                                          hintText: '0',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintStyle: Fonts.subtitle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: ColorApp.decorador(),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text('Cava', style: Fonts.text3()),
                                      const SizedBox(height: 8),
                                      Icon(Icons.inbox,
                                          size: 60, color: ColorApp.blanco()),
                                    ]),
                                    SizedBox(
                                      width: 150,
                                      // height: 0,
                                      child: TextFormField(
                                        controller: cavaController,
                                        validator: Validator.tipoPaquete,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        style:
                                            Fonts.personalizado(sizeFont: 18.0),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorApp.decorador(),
                                          hintText: '0',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintStyle: Fonts.subtitle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: ColorApp.decorador(),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(children: [
                                      Text('Contenedor', style: Fonts.text3()),
                                      const SizedBox(height: 8),
                                      Icon(Icons.storage,
                                          size: 60, color: ColorApp.blanco()),
                                    ]),
                                    SizedBox(
                                      width: 150,
                                      // height: 0,
                                      child: TextFormField(
                                        controller: contenedorController,
                                        validator: Validator.tipoPaquete,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        keyboardType: TextInputType.number,
                                        style:
                                            Fonts.personalizado(sizeFont: 18.0),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: ColorApp.decorador(),
                                          hintText: '0',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.transparent),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintStyle: Fonts.subtitle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Ciudad origen', style: Fonts.text3()),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorApp.decorador(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: ciudadOrigen,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    ciudadOrigen = newValue!;
                                  });
                                },
                                isExpanded: true,
                                underline: Container(),
                                focusColor: Colors.blue,
                                style: TextStyle(color: Colors.white),
                                items: ciudades.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      width: double.infinity,
                                      height: 20.0,
                                      color: ciudadOrigen == value
                                          ? ColorApp.decorador()
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          value,
                                          // textDirection: TextDirection.,
                                          style: Fonts.text2().copyWith(
                                              color: ciudadOrigen == value
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Ciudad destino', style: Fonts.text3()),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorApp.decorador(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButton<String>(
                                value: ciudadDestino,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    ciudadDestino = newValue!;
                                  });
                                },
                                isExpanded: true,
                                underline: Container(),
                                focusColor: Colors.blue,
                                style: TextStyle(color: Colors.white),
                                items: ciudades.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      width: double.infinity,
                                      height: 20.0,
                                      color: ciudadDestino == value
                                          ? ColorApp.decorador()
                                          : Colors.transparent,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          value,
                                          // textDirection: TextDirection.,
                                          style: Fonts.text2().copyWith(
                                              color: ciudadDestino == value
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 28.0),
                            Text('Imagen de empaque', style: Fonts.text3()),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorApp.decorador(),
                                border: Border.all(
                                  color: ColorApp.decorador(),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0,
                                    right: 14.0,
                                    bottom: 10.0,
                                    top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    image != null
                                        ? Container(
                                            width: 200,
                                            height: 200,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.file(
                                                image!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : Icon(
                                            Icons.photo,
                                            size: 70,
                                            color: Colors.white,
                                          ),
                                    ElevatedButton(
                                      onPressed: _getImage,
                                      child: Text(
                                        'Seleccionar Imagen',
                                        style: Fonts.personalizado(
                                            color: Colors.black),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  List<PackAttribute> paquetes = [];
                                  if (formKey.currentState!.validate()) {
                                    if (cajaController.text.isEmpty &&
                                        paqueteController.text.isEmpty &&
                                        sobreController.text.isEmpty &&
                                        maletaController.text.isEmpty &&
                                        cavaController.text.isEmpty &&
                                        contenedorController.text.isEmpty) {
                                      print('No hay tipo empaque');
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    'No se puede crear pedido sin ningún tipo de empaque',
                                                    style: Fonts.personalizado(
                                                        sizeFont: 12.0,
                                                        color: Colors.black)),
                                                const SizedBox(height: 8),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: ColorApp
                                                          .calidoAnalogo(),
                                                    ),
                                                    child: Text('Ok',
                                                        style: Fonts.text3()))
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      if (image == null) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                      'Ingresar imagen del empaque',
                                                      style:
                                                          Fonts.personalizado(
                                                              sizeFont: 12.0,
                                                              color: Colors
                                                                  .black)),
                                                  const SizedBox(height: 8),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: ColorApp
                                                            .calidoAnalogo(),
                                                      ),
                                                      child: Text('Ok',
                                                          style: Fonts.text3()))
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        if (!image!.path
                                            .toLowerCase()
                                            .endsWith('.png')) {
                                          print('debe salir alerta');
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                        'La imagen debe ser formato ".png"',
                                                        style:
                                                            Fonts.personalizado(
                                                                sizeFont: 12.0,
                                                                color: Colors
                                                                    .black)),
                                                    const SizedBox(height: 8),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: ColorApp
                                                              .calidoAnalogo(),
                                                        ),
                                                        child: Text('Ok',
                                                            style:
                                                                Fonts.text3()))
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          imageJson(image!).then((resultado) {
                                            // Hacer algo con el jsonImage, por ejemplo, imprimirlo
                                            if (resultado.isEmpty) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                            'Error al cargar imagen, intente nuevamente',
                                                            style: Fonts
                                                                .personalizado(
                                                                    sizeFont:
                                                                        12.0,
                                                                    color: Colors
                                                                        .black)),
                                                        const SizedBox(
                                                            height: 8),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              primary: ColorApp
                                                                  .calidoAnalogo(),
                                                            ),
                                                            child: Text('Ok',
                                                                style: Fonts
                                                                    .text3()))
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            } else {
                                              base64Image = resultado;
                                              print(
                                                  'ruta imagen ${image!.path.toLowerCase()}');
                                              print('debe entrar al evento');
                                              if (paqueteController
                                                  .text.isNotEmpty) {
                                                int cantidadPaquete = int.parse(
                                                    paqueteController.text);
                                                paquetes.add(PackAttribute(
                                                    tipo: 'Paquete',
                                                    cantidad: cantidadPaquete));
                                              }
                                              if (sobreController
                                                  .text.isNotEmpty) {
                                                int cantidadsobre = int.parse(
                                                    sobreController.text);
                                                paquetes.add(PackAttribute(
                                                    tipo: 'Sobre',
                                                    cantidad: cantidadsobre));
                                              }
                                              if (maletaController
                                                  .text.isNotEmpty) {
                                                int cantidadmaleta = int.parse(
                                                    maletaController.text);
                                                paquetes.add(PackAttribute(
                                                    tipo: 'Maleta',
                                                    cantidad: cantidadmaleta));
                                              }
                                              if (cavaController
                                                  .text.isNotEmpty) {
                                                int cantidadcava = int.parse(
                                                    cavaController.text);
                                                paquetes.add(PackAttribute(
                                                    tipo: 'Cava',
                                                    cantidad: cantidadcava));
                                              }
                                              if (contenedorController
                                                  .text.isNotEmpty) {
                                                int cantidadcontenedor =
                                                    int.parse(
                                                        contenedorController
                                                            .text);
                                                paquetes.add(PackAttribute(
                                                    tipo: 'Contenedor',
                                                    cantidad:
                                                        cantidadcontenedor));
                                              }

                                              // print('LA fecha se ve como: ${fechaController.text} y es tipo ${fechaController.text.runtimeType}');
                                              print('El lista esta $paquetes');
                                              print(
                                                  'En el boton fecha es $fecha y tipo ${fecha.runtimeType}');

                                              // final jsonImage = await imageJson(image);
                                              print(
                                                  ' Sera este el fin de mi: ${base64Image} y es tipo ${base64Image.runtimeType}');
                                              // final DateTime selectedDate = formData['date'];
                                              // print('LA fecha en json esta como ${selectedDate}');
                                              print('Me fue al evento');
                                              OrderDto nuevaOrden = OrderDto(
                                                  fecha: fecha!,
                                                  consecutivo: int.parse(
                                                      consecutivoController
                                                          .text),
                                                  avatar: base64Image,
                                                  destino: ciudadDestino!,
                                                  origen: ciudadOrigen!,
                                                  estado: "En espera",
                                                  packAttributes: paquetes);
                                              context
                                                  .read<CreateOrderBloc>()
                                                  .add(CreateOrderEnterPressed(
                                                      orden: nuevaOrden));
                                            }
                                          });
                                        }
                                      }
                                    }
                                  }
                                },
                                child: const Text('Enviar pedido'),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorApp.calidoAnalogo(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state is CreateOrderInProgress)
                    CreateOrderAnimateWidget(message: 'Creando orden'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String? inputFecha(dynamic value) {
    if (value == null) {
      return 'Selecciona una fecha';
    }
    fecha = DateFormat('yyyy-MM-dd').format(value);
    print(
        'El valor de vlue del input fecha es $fecha y es tipo ${fecha.runtimeType}');
    final now = DateTime.now();
    final minDate = now.add(const Duration(days: 5));
    final maxDate = now.add(const Duration(days: 730));

    if (value.isBefore(minDate)) {
      return 'La fecha minima es de 5 días despues de la actual';
    }
    if (value.isAfter(maxDate)) {
      return 'Supero fecha permitida (maximo 2 años)';
    }

    return null;
  }

  Future<String> imageJson(File? image) async {
    // final formData = formKey.currentState!.value;
    // if (image != null) {
    final imageBytes = await image!.readAsBytes();
    final imageBase64 = base64Encode(imageBytes);
    final jsonData = {'image': imageBase64};
    // jsonImage = imageBase64;
    // Enviar el JSON o realizar otras operaciones
    return imageBase64;
    // }
  }
}
