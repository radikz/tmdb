import 'package:equatable/equatable.dart';

class TvEpisode extends Equatable {
    TvEpisode({
        required this.id,
        required this.name,
        required this.overview,
        required this.voteAverage,
        required this.voteCount,
        required this.airDate,
        required this.episodeNumber,
        required this.productionCode,
        required this.seasonNumber,
        required this.stillPath,
    });

    int id;
    String name;
    String overview;
    num voteAverage;
    int voteCount;
    DateTime airDate;
    int episodeNumber;
    String productionCode;
    int seasonNumber;
    String? stillPath;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      overview,
      voteAverage,
      voteCount,
      airDate,
      episodeNumber,
      productionCode,
      seasonNumber,
      stillPath,
    ];
  }
}
