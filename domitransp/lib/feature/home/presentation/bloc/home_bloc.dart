import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/data/repository/home_dto.dart';
import '../../data/respository/home_repository.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({required this.homeRepository}) : super(HomeUninitialized()){
    on <HomeStarted>(_mapStared);
  }

  Future<void> _mapStared(HomeStarted event, Emitter<HomeState> emit) async {
    print('Entre al bloc de Home');
    emit(HomeLoading());
    try {
      final bannersPromocion = await homeRepository.bannerPromocion();

      emit(HomeSucess(publications: bannersPromocion));

    } catch (e) {
      if(e is ErrorHome){
        emit(HomeFailure(message: e.message));
      } else{
        print('error en el bloc home desconocido: $e y tio ${e.runtimeType}');
        emit(HomeFailure(message: 'Error inesperado'));
      }
    }
    
  }
}
