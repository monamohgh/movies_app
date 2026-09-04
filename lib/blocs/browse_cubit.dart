import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/dio_manager.dart';
import 'package:movies_app/model/movie_model.dart';

abstract class BrowseState {}

class BrowseInitialState extends BrowseState {}

class BrowseLoadingState extends BrowseState {}

class BrowseSuccessState extends BrowseState {
  final Set<String> categories;
  final List<MovieModel> filteredMovies;
  final String selectedGenre;
  final bool isMoviesLoading;

  BrowseSuccessState({
    required this.categories,
    required this.filteredMovies,
    required this.selectedGenre,
    this.isMoviesLoading = false,
  });
}

class BrowseErrorState extends BrowseState {
  final String errorMessage;

  BrowseErrorState({required this.errorMessage});
}

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit(this.dioManager) : super(BrowseInitialState());

  final DioManager dioManager;
  Set<String> genresSet = {};
  String selectedGenre = '';
  List<MovieModel> currentMovies = [];

  Future<void> getBrowseData() async {
    emit(BrowseLoadingState());
    try {
      var initialResponse = await dioManager.fetchMovies();
      List<MovieModel> initialMovies =
      initialResponse.map((e) => MovieModel.fromJson(e)).toList();

      for (var movie in initialMovies) {
        genresSet.addAll(movie.genres);
      }

      if (genresSet.isNotEmpty) {
        selectedGenre = genresSet.first;

        var genreResponse = await dioManager.fetchMovies(genre: selectedGenre);
        currentMovies =
            genreResponse.map((e) => MovieModel.fromJson(e)).toList();

        emit(BrowseSuccessState(
          categories: genresSet,
          filteredMovies: currentMovies,
          selectedGenre: selectedGenre,
          isMoviesLoading: false,
        ));
      } else {
        emit(BrowseSuccessState(
          categories: {},
          filteredMovies: [],
          selectedGenre: '',
        ));
      }
    } catch (e) {
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> changeSelectedGenre(String newGenre) async {
    if (selectedGenre == newGenre) return;

    selectedGenre = newGenre;

    emit(BrowseSuccessState(
      categories: genresSet,
      filteredMovies: [],
      selectedGenre: selectedGenre,
      isMoviesLoading: true,
    ));

    try {
      var response = await dioManager.fetchMovies(genre: newGenre);
      currentMovies = response.map((e) => MovieModel.fromJson(e)).toList();

      emit(BrowseSuccessState(
        categories: genresSet,
        filteredMovies: currentMovies,
        selectedGenre: selectedGenre,
        isMoviesLoading: false,
      ));
    } catch (e) {
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }}