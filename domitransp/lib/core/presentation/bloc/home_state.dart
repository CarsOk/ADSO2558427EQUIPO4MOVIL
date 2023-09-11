part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeUninitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSucess extends HomeState {}

class HomeFailure extends HomeState {}