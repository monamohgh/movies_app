import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/model/movie_details_model.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieData movieData;
  final List<MovieSuggestion> suggestions;
  final bool isBookmarked;

  MovieDetailsSuccessState({
    required this.movieData,
    required this.suggestions,
    required this.isBookmarked,
  });

  MovieDetailsSuccessState copyWith({bool? isBookmarked}) {
    return MovieDetailsSuccessState(
      movieData: movieData,
      suggestions: suggestions,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String message;
  MovieDetailsErrorState(this.message);
}

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final DioManager _dioManager;

  MovieDetailsCubit(this._dioManager) : super(MovieDetailsInitialState());

  void loadMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final movieData = await _dioManager.fetchMovieDetails(movieId);
      final suggestions = await _dioManager.fetchMovieSuggestions(movieId);
      emit(MovieDetailsSuccessState(
        movieData: movieData,
        suggestions: suggestions,
        isBookmarked: false,
      ));
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }

  void toggleBookmark() {
    if (state is MovieDetailsSuccessState) {
      final currentState = state as MovieDetailsSuccessState;
      emit(currentState.copyWith(isBookmarked: !currentState.isBookmarked));
    }
  }
}