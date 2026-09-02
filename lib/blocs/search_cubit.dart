import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {
  final List<dynamic> movies;
  SearchInitialState([this.movies = const []]);
}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final List<dynamic> movies;
  SearchSuccessState(this.movies);
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState(this.message);
}

class SearchCubit extends Cubit<SearchState> {
  final DioManager dioManager = DioManager();

  SearchCubit() : super(SearchInitialState()) {

    loadSuggestions();
  }

  void loadSuggestions() async {
    emit(SearchLoadingState());
    try {
      final movies = await dioManager.searchMovies('');
      emit(SearchSuccessState(movies));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  void search(String query) async {
    if (query.trim().isEmpty) {
      loadSuggestions();
      return;
    }

    emit(SearchLoadingState());
    try {
      final movies = await dioManager.searchMovies(query);
      emit(SearchSuccessState(movies));
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}