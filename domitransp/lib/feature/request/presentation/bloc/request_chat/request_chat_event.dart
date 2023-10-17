part of 'request_chat_bloc.dart';


abstract class RequestChatEvent {}

class RequestChatStarted extends RequestChatEvent{
  RequestListDto requestDto;

  RequestChatStarted({required this.requestDto});
}

class SendResponseEnterPressed extends RequestChatEvent{
  RequestListDto requestDto;
  String content;

  SendResponseEnterPressed({required this.requestDto, required this.content});
}

class RefreshRequestEnterPressed extends RequestChatEvent{
  RequestListDto requestDto;

  RefreshRequestEnterPressed({required this.requestDto});
}