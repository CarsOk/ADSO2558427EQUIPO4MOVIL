part of 'request_chat_bloc.dart';

@immutable
abstract class RequestChatState {}

class RequestChatInitial extends RequestChatState {}

class RequestChatInProgress extends RequestChatState {}

// ignore: must_be_immutable
class RequestChatFailure extends RequestChatState {
  String message;

  RequestChatFailure({required this.message});
}

// ignore: must_be_immutable
class RequestChatSuccess extends RequestChatState {
  List<ChatDto> chatList;

  RequestChatSuccess({required this.chatList});
}


class RequestChatClose extends RequestChatState {}

