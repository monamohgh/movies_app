import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<dynamic> availableMovies;
  final List<dynamic> actionMovies;
  final List<dynamic> dramaMovies;
  final List<dynamic> sciFiMovies;

  HomeSuccessState({
    required this.availableMovies,
    required this.actionMovies,
    required this.dramaMovies,
    required this.sciFiMovies,
  });
}

class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState(this.errorMessage);
}

class HomeCubit extends Cubit<HomeState> {
  final DioManager dioManager;

  HomeCubit(this.dioManager) : super(HomeInitialState());

  Future<void> getHomeData() async {
    emit(HomeLoadingState());
    try {
      final results = await Future.wait([
        dioManager.fetchMovies(sortBy: 'date_added', limit: 10),
        dioManager.fetchMovies(genre: 'action', limit: 10),
        dioManager.fetchMovies(genre: 'drama', limit: 10),
        dioManager.fetchMovies(genre: 'sci-fi', limit: 10),
      ]);

      emit(HomeSuccessState(
        availableMovies: results[0],
        actionMovies: results[1],
        dramaMovies: results[2],
        sciFiMovies: results[3],
      ));
    } catch (e) {
      emit(HomeErrorState('An error occurred while loading the data, please try again.'));
    }
  }
}