part of 'new_request_bloc.dart';

abstract class NewRequestEvent {}


class NewRequestEnterPressed extends NewRequestEvent{
  final String title;
  final String name;
  final String subject;
  final String email;


  NewRequestEnterPressed({required this.title,required this.name, required this.subject, required this.email});
}