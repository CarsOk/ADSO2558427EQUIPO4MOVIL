import 'package:domitransp/feature/request/data/repository/request_repository.dart';
import 'package:domitransp/feature/request/presentation/bloc/new_bloc/new_request_bloc.dart';
import 'package:domitransp/widgets/loading_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/form_field/form_validator_cubit.dart';

class NewRequestPage extends StatelessWidget {
  final _titleController = TextEditingController();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
  bool isFormValid = false;
  final _formKey = GlobalKey<FormState>(); // Agrega esta línea para definir _formKey

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RequestRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewRequestBloc(
              requestRepository: context.read<RequestRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => FormValidatorCubit(),
          ),
        ],
        child: BlocConsumer<NewRequestBloc, NewRequestState>(
          listener: (context, state) {
            if (state is NewRequestInSuccess) {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, 'list_request');
            }
          },
          builder: (context, state) {
            if(state is NewRequestInProgress){
              return CustomLoadingAnimation();
            } else if(state is NewRequestInFailure){
              return AlertDialog(
                title: const Text("Error"),
                content: Text(state.message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Aceptar"),
                  ),
                ],
              );
            } else if(state is NewRequestInSuccess){
              return AlertDialog(
                title: const Text("Enhorabuena"),
                content: Text("Se ha creado exitosamente"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'list_request');
                    },
                    child: Text("Aceptar"),
                  ),
                ],
              );
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('Solicitar petición'),
                backgroundColor: Color(0xFF4E0096),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form( // Utiliza un formulario para envolver los campos de texto
                    key: _formKey, // Asigna la clave del formulario
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(labelText: 'Título'),
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Nombre'),
                        ),
                        TextField(
                          controller: _subjectController,
                          decoration: InputDecoration(labelText: 'Asunto'),
                        ),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xFF4E0096)),
                          ),
                          onPressed: () {
                            final titleIsValid = _titleController.text.isNotEmpty;
                            final nameIsValid = _nameController.text.isNotEmpty;
                            final subjectIsValid = _subjectController.text.isNotEmpty;
                            final emailIsValid = isValidEmail(_emailController.text);

                            // Verificar si todos los campos son válidos
                            if (titleIsValid && nameIsValid && subjectIsValid && emailIsValid) {
                              // Todos los campos son válidos, ejecuta el evento del bloc aquí
                              print("Todos los campos son válidos. Ejecutando el evento del bloc.");
                              context.read<NewRequestBloc>().add(
                              NewRequestEnterPressed(
                                  title: _titleController.text, name: _nameController.text, subject: _subjectController.text, email: _emailController.text));
                            } else {
                              // Al menos un campo no es válido, muestra un cuadro de diálogo emergente
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Campos incompletos"),
                                    content: Text("Por favor, complete todos los campos correctamente."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                                        },
                                        child: Text("Aceptar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        width: double.infinity,
                        height: 42.0,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
