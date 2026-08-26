import 'package:dio/dio.dart';
import 'package:movies_app/model/movie_details_model.dart';


class DioManager {
  // ==================== Details API ====================

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://movies-api.accel.li/api/v2/',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  // ==================== Home API ====================

  final Dio _homeDio = Dio(
    BaseOptions(
      baseUrl: 'https://movies-api.accel.li/api/v2/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  // ==================== Movie Details ====================

  Future<MovieData> fetchMovieDetails(int movieId) async {
    try {
      final response = await _dio.get(
        '/movie_details.json',
        queryParameters: {
          'movie_id': movieId,
          'with_images': false,
          'with_cast': false,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return MovieData.fromJson(response.data['data']['movie']);
      } else {
        throw Exception('Failed to load movie details');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error occurred');
    }
  }

  // ==================== Movie Suggestions ====================

  Future<List<MovieSuggestion>> fetchMovieSuggestions(int movieId) async {
    try {
      final response = await _dio.get(
        '/movie_suggestions.json',
        queryParameters: {
          'movie_id': movieId,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final List moviesList = response.data['data']['movies'] ?? [];

        return moviesList
            .map((e) => MovieSuggestion.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load suggestions');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error occurred');
    }
  }

  // ==================== Parental Guides ====================

  Future<List<ParentalGuide>> fetchParentalGuides(int movieId) async {
    try {
      final response = await _dio.get(
        '/movie_parental_guides.json',
        queryParameters: {
          'movie_id': movieId,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final List guidesList =
            response.data['data']['parental_guides'] ?? [];

        return guidesList
            .map((e) => ParentalGuide.fromJson(e))
            .toList();
      } else {
        throw Exception('Failed to load parental guides');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error occurred');
    }
  }

  // ==================== Home Movies ====================

  Future<List<dynamic>> fetchMovies({String? genre, String? sortBy, int limit = 20}) async {
    try {
      final response = await _homeDio.get(
        '/list_movies.json',
        queryParameters: {
          if (genre != null) 'genre': genre,
          if (sortBy != null) 'sort_by': sortBy,
          'limit': limit,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final List moviesList = response.data['data']['movies'] ?? [];
        return moviesList;
      } else {
        throw Exception('Failed to load movies');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Network error occurred');
    }
  }
}