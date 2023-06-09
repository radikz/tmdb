import 'package:equatable/equatable.dart';
import 'package:tv/data/models/tv_episode_model.dart';

import '../../domain/entities/detail_season.dart';

class DetailSeasonModel extends Equatable {
  const DetailSeasonModel({
    required this.airDate,
    required this.id,
    required this.name,
    required this.overview,
    required this.episodes,
    required this.posterPath,
    required this.seasonNumber,
  });

  final DateTime airDate;
  final int id;
  final String name;
  final List<TvEpisodeModel> episodes;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory DetailSeasonModel.fromJson(Map<String, dynamic> json) =>
      DetailSeasonModel(
        airDate: DateTime.parse(json["air_date"]),
        id: json["id"],
        name: json["name"],
        episodes: List<TvEpisodeModel>.from(
            json["episodes"].map((x) => TvEpisodeModel.fromJson(x))),
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  DetailSeason toEntity() => DetailSeason(
      airDate: airDate,
      id: id,
      name: name,
      episodes: episodes.map((e) => e.toEntity()).toList(),
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber);

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
