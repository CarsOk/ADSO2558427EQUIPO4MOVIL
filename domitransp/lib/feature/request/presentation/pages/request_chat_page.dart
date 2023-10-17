import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:domitransp/core/data/repository/request_list_dto.dart';
import '../../data/repository/request_repository.dart';
import '../bloc/request_chat/request_chat_bloc.dart';
import '../widget/chat_widget.dart';


class RequestChatPage extends StatelessWidget{
  RequestListDto request;
  Timer? _timer;
  final responseController = TextEditingController();
  RequestChatPage({required this.request});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RequestRepository(),
      child: BlocProvider(
        create: (context) => RequestChatBloc(
          requestRepository: context.read<RequestRepository>(),
        )..add(RequestChatStarted(requestDto: request)),
        child: BlocConsumer<RequestChatBloc, RequestChatState>(
          listener: (context, state) {
            _timer?.cancel();
            _timer = Timer.periodic(Duration(seconds: 20), (timer) {
              context.read<RequestChatBloc>().add(RefreshRequestEnterPressed(requestDto: request));
              print('Me ejecuté otra vez por temporizador');
            });
          },
          builder: (context, state){
            if(state is RequestChatSuccess){
              return Scaffold(
                 appBar: AppBar(
                  title: Text('Chat'),
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
                body: Column(
                  children: [
                    Expanded(child: SingleChildScrollView(child: ChatWidget(chatList: state.chatList)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0, top: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(4, 4, 4, 0.202),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            width: 300,
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 280,
                                    child: TextFormField(
                                      controller: responseController,
                                      decoration:InputDecoration(
                                        hintText: 'Mensaje',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if(responseController.text.isNotEmpty){
                              context.read<RequestChatBloc>().add(
                                SendResponseEnterPressed(content: responseController.text, requestDto: request)
                              );
                              responseController.text = '';
                              await Future.delayed(Duration(seconds: 2));
                              print('Fin de la espera de 2 segundos');
                      
                              context.read<RequestChatBloc>().add(RefreshRequestEnterPressed(requestDto: request)
                              );

                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.purple,
                            ),
                            child: Icon(Icons.send, color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              );
            }
            print(state.runtimeType);
            return Text('Soy el chat');
          }
          
        ),
      ),

    );
  }

}