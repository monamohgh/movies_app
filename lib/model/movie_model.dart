class MovieModel {
  final List<String> genres;
  final String image;
  final double rating;
  final int id;
  final String title;
  MovieModel({required this.genres,required this.id,required this.image,required this.rating,required this.title});
  factory MovieModel.fromJson(Map<String,dynamic>json){
    return MovieModel(
        genres:List<String>.from(json['genres'] ?? [])
        , id: json['id'] ?? 0,
        image: json['medium_cover_image'] ?? '' ,
        rating:  (json['rating'] as num?)?.toDouble() ?? 0.0,
        title: json['title']??''
    );
  }

}