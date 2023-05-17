import 'package:equatable/equatable.dart';

class TvEpisode extends Equatable {
  const TvEpisode({
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

  final int id;
  final String name;
  final String overview;
  final num voteAverage;
  final int voteCount;
  final DateTime? airDate;
  final int episodeNumber;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;

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
