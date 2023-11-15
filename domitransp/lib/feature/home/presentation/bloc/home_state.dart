part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeUninitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSucess extends HomeState {
  List<HomeDto> publications;

  HomeSucess({required this.publications});
}

class HomeFailure extends HomeState {
  String message;

  HomeFailure({required this.message});
}