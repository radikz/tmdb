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

  DateTime airDate;
  int id;
  String name;
  List<TvEpisode> episodes;
  String overview;
  String posterPath;
  int seasonNumber;

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
