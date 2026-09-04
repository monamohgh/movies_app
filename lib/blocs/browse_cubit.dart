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

  BrowseSuccessState(
      {required this.categories,
      required this.filteredMovies,
      required this.selectedGenre});
}

class BrowseErrorState extends BrowseState {
  final String errorMessage;

  BrowseErrorState({required this.errorMessage});
}

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit(this.dioManager) : super(BrowseInitialState());
  final DioManager dioManager;
  List<MovieModel> allMovies = [];
  Set<String> genresSet = {};
  String selectedGenre = '';

  Future<void> getBrowseData() async {
    emit(BrowseLoadingState());
    // print('⏳ Started loading data...');
    try {
      var response = await dioManager.fetchMovies();
      allMovies = response.map((e) => MovieModel.fromJson(e)).toList();
      // print('Fetched Movies Count: ${allMovies.length}');
      for (int i = 0; i < allMovies.length; i++) {
        genresSet.addAll(allMovies[i].genres);
      }
      // print(' Unique Genres Found: $genresSet');
      if (genresSet.isNotEmpty) {
        selectedGenre = genresSet.first;
      }
      List<MovieModel> filteredMovies = allMovies
          .where(
            (movie) => movie.genres.contains(selectedGenre),
          )
          .toList();
      // print(' Selected Genre: $selectedGenre');
      // print(' Filtered Movies Count: ${filteredMovies.length}');
      emit(BrowseSuccessState(
          categories: genresSet,
          filteredMovies: filteredMovies,
          selectedGenre: selectedGenre));
    } catch (e) {
      // print(' Error occurred: $e');
      emit(BrowseErrorState(errorMessage: e.toString()));
    }
  }

  void changeSelectedGenre(String newGenre) {
    selectedGenre = newGenre;
    List<MovieModel> filteredMovies = allMovies
        .where(
          (movie) => movie.genres.contains(selectedGenre),
        )
        .toList();
    emit(BrowseSuccessState(
        categories: genresSet,
        filteredMovies: filteredMovies,
        selectedGenre: selectedGenre));
  }
}
