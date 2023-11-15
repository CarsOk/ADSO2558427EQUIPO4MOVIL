  import 'package:domitransp/widgets/loading_chat_animate.dart';
import 'package:flutter/material.dart';
  import 'package:domitransp/feature/request/data/repository/request_repository.dart';
  import 'package:domitransp/widgets/loading_animate.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  import '../../../../widgets/failure_widget.dart';
import '../bloc/request_list/request_list_bloc.dart';
import 'request_chat_page.dart';


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
                                    subtitle: Text(DateFormat('HH:mm dd-MM-yyyy').format(request.createdAt).toString()),
                                    leading: Icon(Icons.note),
                                    trailing: const Icon(Icons.arrow_forward_ios),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RequestChatPage(request: request),
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
                      return LoadingChatAnimate();
                    } else if(state is RequestListFailure){
                      return(
                        FailureWidget(
                          function: ()  => BlocProvider.of<RequestListBloc>(context).add(RequestListStarted()),
                          message: state.message,
                        )
                      );
                      
                    } else{
                      return (Text('No hay nada en la lista'));
                
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