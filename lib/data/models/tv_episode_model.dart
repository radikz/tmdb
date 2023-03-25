import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/tv_episode.dart';

class TvEpisodeModel extends Equatable {
  TvEpisodeModel({
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
  String stillPath;

  factory TvEpisodeModel.fromJson(Map<String, dynamic> json) => TvEpisodeModel(
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
        airDate: DateTime.parse(json["air_date"]),
        episodeNumber: json["episode_number"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber,
        "production_code": productionCode,
        "season_number": seasonNumber,
        "still_path": stillPath,
      };

  TvEpisode toEntity() => TvEpisode(
      id: id,
      name: name,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      airDate: airDate,
      episodeNumber: episodeNumber,
      productionCode: productionCode,
      seasonNumber: seasonNumber,
      stillPath: stillPath);

  @override
  List<Object> get props {
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