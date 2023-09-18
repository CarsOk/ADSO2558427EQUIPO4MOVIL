import 'package:domitransp/feature/consult/presentation/widgets/failure_widget.dart';
import 'package:domitransp/feature/consult/presentation/widgets/success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domitransp/feature/consult/data/repository/consult_repository.dart';
import 'package:domitransp/feature/consult/presentation/bloc/consult_bloc.dart';
import '../../../../widgets/loading_animate.dart';

class Consult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final codigoController = TextEditingController();
    final size = MediaQuery.of(context).size;

    return RepositoryProvider(
      create: (context) => ConsultRepository(),
      child: BlocProvider(
        create: (context) =>
            ConsultBloc(consultRepository: context.read<ConsultRepository>()),
        child: Scaffold(
          body: BlocBuilder<ConsultBloc, ConsultState>(
            builder: (context, state) {
              return Stack(
                children: [
                  caja(size),
                  icono_logo(),
                  SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 250),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text('Rastrear Envío',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: codigoController,
                                  autocorrect: false,
                                  decoration:
                                      const InputDecoration(
                                    enabledBorder:
                                        UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.purple),
                                    ),
                                    focusedBorder:
                                        UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.deepPurple,
                                          width: 2),
                                    ),
                                    hintText:
                                        "Codigo de seguimiento",
                                    prefixIcon: Icon(
                                      Icons.local_shipping,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 33),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)),
                                  disabledColor: Colors.grey,
                                  color: Colors.deepPurple,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80,
                                        vertical: 15),
                                    child: Text(
                                      'Buscar',
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    String codigo =
                                        codigoController.text;
              
                                    context.read<ConsultBloc>().add(ConsultEnterPressed(codigo: codigo));
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is ConsultInProgress)
                  CustomLoadingAnimation(),
                if (state is ConsultLoadSuccess)
                  SuccessConsultWidget(consultDto: state.consultaDto),
                  
                if (state is ConsultLoadFailure)
                  FailureConsultWidget(message: state.message),
                ]
              );
            },
          ),
        ),
      ),
    );
  }

  SafeArea icono_logo() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container caja(Size size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 170, 1),
        ]),
      ),
      width: double.infinity,
      height: size.height * 0.4,
    );
  }
}
