import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestListPage extends StatefulWidget{
  
 
  @override
  State<RequestListPage> createState() => _RequestListPageState();

}

class _RequestListPageState extends State<RequestListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                title: Text('Peticiones'),
                backgroundColor: Color(0xFF4E0096),
              ),
      body: SingleChildScrollView(
        // child: Padding(
        //   padding: EdgeInsets.all(18.0),
        //   child: Column(children: [
        //     ListView.builder(
        //       itemCount: getRequestList.length
        //       itemBuilder: itemBuilder
        //       )
        //   ]),
        // ),
        child: Text('Pagina de lista de pedidos'),
      )
    );
  }

  Future<List<String>> getRequestList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? codigoList = await prefs.getStringList('codigoList');

    return codigoList ?? [];
  }

}