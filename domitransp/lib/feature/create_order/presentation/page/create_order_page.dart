import 'package:domitransp/feature/global/color_app.dart';
import 'package:domitransp/feature/validator/validator.dart';
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
  TextEditingController consecutivoController = TextEditingController();

  TextEditingController paqueteController = TextEditingController();
  TextEditingController sobreController = TextEditingController();
  TextEditingController cavaController = TextEditingController();
  TextEditingController cajaController = TextEditingController();
  TextEditingController maletaController = TextEditingController();
  TextEditingController contenedorController = TextEditingController();

  
  File? _image;
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
        child: Scaffold(
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
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18.0, top: 8.0, bottom: 2.0),
                  child: FormBuilder(
                    key: _formKey,
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
                          style: Fonts.personalizado(sizeFont: 14.0),
                          inputType: InputType.date,
                          format: DateFormat('dd-MM-yyyy'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (DateTime? value) =>
                              Validator.inputDate(value),
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
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children: [
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    style: Fonts.personalizado(sizeFont:  18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorApp.decorador(),
                                      hintText: '0',
                                     
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintStyle:  Fonts.subtitle(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children: [
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    style: Fonts.personalizado(sizeFont:  18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorApp.decorador(),
                                      hintText: '0',
                                     
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintStyle:  Fonts.subtitle(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children: [
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    style: Fonts.personalizado(sizeFont:  18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorApp.decorador(),
                                      hintText: '0',
                                     
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintStyle:  Fonts.subtitle(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children: [
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    style: Fonts.personalizado(sizeFont:  18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorApp.decorador(),
                                      hintText: '0',
                                     
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintStyle:  Fonts.subtitle(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children: [
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
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.number,
                                    style: Fonts.personalizado(sizeFont:  18.0),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorApp.decorador(),
                                      hintText: '0',
                                     
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      hintStyle:  Fonts.subtitle(),
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
                          child:DropdownButton<String>(
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
                          items: ciudades.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: double.infinity,
                                height: 20.0,
                                color: ciudadOrigen == value? ColorApp.decorador() : Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    value,
                                    // textDirection: TextDirection.,
                                    style: Fonts.text2().copyWith(color: ciudadOrigen == value ? Colors.white : Colors.black), 
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
                          child:DropdownButton<String>(
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
                          items: ciudades.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: double.infinity,
                                height: 20.0,
                                color: ciudadDestino == value? ColorApp.decorador() : Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    value,
                                    // textDirection: TextDirection.,
                                    style: Fonts.text2().copyWith(color: ciudadDestino == value ? Colors.white : Colors.black), 
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        ),
                        const SizedBox(height: 20),
                      
                        Container(
                          width: double.infinity,
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                : Icon(Icons.photo, size: 70, color: Colors.white,),
                            ElevatedButton(
                              onPressed: _getImage,
                              child: Text('Seleccionar Imagen'),
                            ),
                                    
                                  ],
                                ),
                              ),
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
