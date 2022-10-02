class PopularModel {
  PopularModel({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? title;
  double? voteAverage;
  int? voteCount;
  factory PopularModel.frommap(Map<String, dynamic> map) => PopularModel(
        backdropPath: map["backdrop_path"],
        id: map["id"],
        originalLanguage: map["original_language"],
        originalTitle: map["original_title"],
        overview: map["overview"],
        popularity: map["popularity"].toDouble(),
        posterPath: map["poster_path"],
        title: map["title"],
        voteAverage: map["vote_average"].toDouble(),
        voteCount: map["vote_count"],
      );

  Map<String, dynamic> tomap() => {
        "backdrop_path": backdropPath,
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}
