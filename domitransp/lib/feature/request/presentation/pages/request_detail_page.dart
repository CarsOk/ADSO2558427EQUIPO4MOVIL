import 'package:flutter/material.dart';

import '../../../../core/data/repository/request_list_dto.dart';

class RequestDetailPage extends StatelessWidget{
  RequestListDto codeDetail;
  RequestDetailPage({required this.codeDetail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Soy pagina de detalle :D')
    );
  }

}