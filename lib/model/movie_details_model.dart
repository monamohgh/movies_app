class MovieData {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final int likeCount;
  final String descriptionFull;
  final String largeCoverImage;
  final String backgroundImageUrl;
  final List<String> genres;
  final List<CastMember>? cast;
  final String? largeScreenshot1;
  final String? largeScreenshot2;
  final String? largeScreenshot3;

  MovieData({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.likeCount,
    required this.descriptionFull,
    required this.largeCoverImage,
    required this.backgroundImageUrl,
    required this.genres,
    this.cast,
    this.largeScreenshot1,
    this.largeScreenshot2,
    this.largeScreenshot3,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) {
    return MovieData(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      descriptionFull: json['description_full'] ?? '',
      largeCoverImage: json['large_cover_image'] ?? '',
      backgroundImageUrl: json['background_image_original'] ?? json['background_image'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      largeScreenshot1: json['large_screenshot_image1'],
      largeScreenshot2: json['large_screenshot_image2'],
      largeScreenshot3: json['large_screenshot_image3'],
      cast: json['cast'] != null
          ? (json['cast'] as List).map((i) => CastMember.fromJson(i)).toList()
          : [],
    );
  }
}

class CastMember {
  final String name;
  final String characterName;
  final String? urlSmallImage;

  CastMember({
    required this.name,
    required this.characterName,
    this.urlSmallImage,
  });

  factory CastMember.fromJson(Map<String, dynamic> json) {
    return CastMember(
      name: json['name'] ?? '',
      characterName: json['character_name'] ?? '',
      urlSmallImage: json['url_small_image'],
    );
  }
}

class MovieSuggestion {
  final int id;
  final String title;
  final double rating;
  final String mediumCoverImage;

  MovieSuggestion({
    required this.id,
    required this.title,
    required this.rating,
    required this.mediumCoverImage,
  });

  factory MovieSuggestion.fromJson(Map<String, dynamic> json) {
    return MovieSuggestion(
      id: json['id'] ,
      title: json['title'] ,
      rating: (json['rating'] as num?)!.toDouble() ,
      mediumCoverImage: json['medium_cover_image'] ,
    );
  }

}

class ParentalGuide {
  final String type;
  final String parentalGuideText;

  ParentalGuide({
    required this.type,
    required this.parentalGuideText,
  });

  factory ParentalGuide.fromJson(Map<String, dynamic> json) {
    return ParentalGuide(
      type: json['type'] ,
      parentalGuideText: json['parental_guide_text'] ,
    );
  }
}