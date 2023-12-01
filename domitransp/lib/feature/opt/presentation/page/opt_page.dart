import 'package:domitransp/feature/home/presentation/page/home_page.dart';
import 'package:domitransp/widgets/loading_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/data/repository/user_repository.dart';
import '../../../../core/presentation/widgets/body.dart';
import '../../../global/color_app.dart';
import '../../../validator/validator.dart';
import '../bloc/opt_bloc.dart';

final _formkey = GlobalKey<FormState>();

class OptPage extends StatelessWidget {
  String email;
  TextEditingController pinputController = TextEditingController();
  OptPage({super.key, required this.email});
  final defaultPinTheme = PinTheme(
    textStyle: GoogleFonts.poppins(
      textStyle: const TextStyle(
        color: Color.fromRGBO(255, 255, 255, 0.863),
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
      ),
    ),
    // decoration: BoxDecoration(
    //   border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    //   borderRadius: BorderRadius.circular(20),
    // ),
  );
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocProvider(
        create: (context) =>
            OptBloc(userRepository: context.read<UserRepository>()),
        child: BlocConsumer<OptBloc, OptState>(
          listener: (context, state) {
            if (state is OptSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Body(),
                ),
              );
            } else if (state is OptFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
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
              ),
              body: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.asset(
                    'assets/picture/fondo/fondo-inicio.png',
                    fit: BoxFit.cover,
                  ),
                  SafeArea(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Escribe tu codigo',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.945),
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 50.0, right: 50.0),
                                      child: Column(
                                        children: [
                                          Pinput(
                                            validator: Validator.pinput,
                                            controller: pinputController,
                                            length: 4,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            defaultPinTheme: PinTheme(
                                              textStyle: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 0.863),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                              height: 48.0,
                                              width: 48.0,
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                color: ColorApp.principal(
                                                    color: const Color.fromARGB(
                                                        197, 135, 33, 153)),
                                                border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            'Se envió a $email un código de verificación',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Color.fromRGBO(
                                                    255, 255, 255, 0.945),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w300,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 50.0,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    context.read<OptBloc>().add(
                                          OptEnterPressed(
                                              code: pinputController.text
                                                  .toString(),
                                              email: email),
                                        );
                                  } else {
                                    print('no es correcto el pinput');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: ColorApp.calidoAnalogo(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Text(
                                  'Confirmar',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      color:
                                          Color.fromRGBO(255, 255, 255, 0.863),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is OptInProgress) CustomLoadingAnimation(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
