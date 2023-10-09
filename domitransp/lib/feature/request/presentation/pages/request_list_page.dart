  import 'package:domitransp/feature/request/data/repository/request_repository.dart';
  import 'package:domitransp/widgets/loading_animate.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  import '../bloc/request_list/request_list_bloc.dart';
  import 'request_detail_page.dart';

  class RequestListPage extends StatelessWidget{
    
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
                  title: Text('Peticiones'),
                  backgroundColor: Color(0xFF4E0096),
                  actions: <Widget>[
                    IconButton(
                        onPressed: (){
                        Navigator.pushNamed(context, 'new_request');
                      }, 
                      icon: Icon(Icons.note_add)
                    )
                  ],
                ),
        body: RepositoryProvider(
          create: (context) => RequestRepository(),
            child: BlocProvider(
                create: (context) => RequestListBloc(requestRepository: context.read<RequestRepository>())..add(RequestListStarted()),
                child: BlocBuilder<RequestListBloc, RequestListState>(
                  builder: (context, state) {
                    
                    if (state is RequestListSuccess){
                      final requests = state.listaPedidos;
                      // return SingleChildScrollView(
                      // child: Padding(
                      //     padding: EdgeInsets.all(18.0),

                            return ListView.builder(
                              itemCount: requests.length,
                              itemBuilder: (context, index) {
                                if(index < state.listaPedidos.length){
                                  final request = requests[index];
                                  return ListTile(
                                    title: Text(request.title),
                                    subtitle: Text(request.createdAt.toIso8601String()),
                                    leading: Icon(Icons.car_rental),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      // Navega a la página de detalles y pasa los datos de la persona
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RequestDetailPage(codeDetail: request),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }
                            );
                        // ),
                        // child: Text('Pagina de lista de pedidos'),
                      // );
                    }else if(state is RequestListInProgress){
                      return CustomLoadingAnimation();
                    } else if(state is RequestListEmpty){
                      return (Text('No hay nada en la lista'));
                    } else{
                      return(Text('Explotoooooo'));
                    }
                    
                  },
                ),
              ),
        )
      );
    }

    Future<List<String>> getRequestList() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> codigoList = await prefs.getStringList('codigoList') ?? [];

      return codigoList;
    }
  }