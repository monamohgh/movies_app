class SavedMovie {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;

  SavedMovie({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
  });
}

class MovieDataStore {
  static List<SavedMovie> watchList = [];
  static List<SavedMovie> historyList = [];

  static void addToWatchList(SavedMovie movie) {
    if (!watchList.any((m) => m.id == movie.id)) {
      watchList.add(movie);
    }
  }

  static void addToHistory(SavedMovie movie) {
    if (!historyList.any((m) => m.id == movie.id)) {
      historyList.add(movie);
    }
  }
}