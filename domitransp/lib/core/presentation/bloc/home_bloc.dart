import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../data/repository/home_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeUninitialized()){
    on <HomeStarted>(_mapStared);
  }

  Future<void> _mapStared(HomeStarted event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    bool bannerPromocion = await homeRepository.bannerPromocion();

    if (bannerPromocion){
      emit(HomeSucess());
    } else {
      emit(HomeFailure());
    }
  }
}
