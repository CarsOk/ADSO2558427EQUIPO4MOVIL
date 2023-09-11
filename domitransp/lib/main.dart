import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Domitransp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController codigoController = TextEditingController();
  List<Map<String, dynamic>> users = [];

  Future<List<Map<String, dynamic>>> buscarRegistro(String codigo) async {
    final connection = PostgreSQLConnection(
      'b5xn4aiw71dpvzecdgzw-postgresql.services.clever-cloud.com',
      5432,
      'b5xn4aiw71dpvzecdgzw',
      username: 'u11nk76ov6hufjlqcdvy',
      password: 'qESlbEQ5OahuAKZkrhXYjgcNhmoO50',
    );

    await connection.open();

    final results = await connection.query(
      'SELECT * FROM orders WHERE origen = @codigo',
      substitutionValues: {'codigo': codigo},
    );

    await connection.close();

    return results.map((row) => row.toColumnMap()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            caja(size),
            icono_logo(),
            search_form(context),
          ],
        ),
      ),
    );
    
  }
  SingleChildScrollView search_form(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 250),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            height: 300,
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
                    style: Theme.of(context).textTheme.headline6),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: codigoController,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2),
                          ),
                          hintText: "Codigo de seguimiento",
                          prefixIcon: Icon(
                            Icons.local_shipping,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 33),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        color: Colors.deepPurple,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 80, vertical: 15),
                          child: Text(
                            'Buscar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () async {
                          final codigo = codigoController.text;
                          final registros = await buscarRegistro(codigo);

                          if (registros.isNotEmpty) {
                            final registro = registros.first;
                            final id = registro['id'];
                            final fecha = registro['fecha'];
                            final consecutivo = registro['consecutivo'];
                            final destino = registro['destino'];
                            final origen = registro['origen'];

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Información del envío',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      Text('ID: $id'),
                                      Text('Fecha: $fecha'),
                                      Text('Consecutivo: $consecutivo'),
                                      Text('Destino: $destino'),
                                      Text('Origen: $origen'),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.deepPurple,
                                          onPrimary: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'No se encontró el envío',
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.deepPurple,
                                          onPrimary: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Crear una nueva contraseña',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
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
      child: Stack(
        children: [
          Positioned(child: burbuja(), top: 90, left: 30),
          Positioned(child: burbuja(), top: -40, left: -30),
          Positioned(child: burbuja(), top: -50, right: -20),
          Positioned(child: burbuja(), bottom: -50, left: 10),
          Positioned(child: burbuja(), bottom: 120, right: -20),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}

