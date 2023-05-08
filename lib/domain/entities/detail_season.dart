import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';

class DetailSeason extends Equatable {
  DetailSeason({
    required this.airDate,
    required this.id,
    required this.name,
    required this.episodes,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final DateTime airDate;
  final int id;
  final String name;
  final List<TvEpisode> episodes;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  @override
  List<Object?> get props {
    return [
      airDate,
      id,
      name,
      episodes,
      overview,
      posterPath,
      seasonNumber,
    ];
  }
}
