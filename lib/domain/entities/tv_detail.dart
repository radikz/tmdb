import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';

import 'genre.dart';

class TvDetail extends Equatable {
    
TvDetail({
        required this.backdropPath,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.languages,
        required this.lastAirDate,
        required this.lastEpisodeToAir,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.seasons,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
    });

    String? backdropPath;
    List<int> episodeRunTime;
    DateTime firstAirDate;
    List<Genre> genres;
    String homepage;
    int id;
    bool inProduction;
    List<String> languages;
    DateTime lastAirDate;
    TvEpisode lastEpisodeToAir;
    String name;
    int numberOfEpisodes;
    int numberOfSeasons;
    List<String> originCountry;
    String originalLanguage;
    String originalName;
    String overview;
    double popularity;
    String? posterPath;
    List<Season> seasons;
    String status;
    String tagline;
    String type;
    double voteAverage;
    int voteCount;

  @override
  List<Object?> get props {
    return [
      backdropPath,
      episodeRunTime,
      firstAirDate,
      genres,
      homepage,
      id,
      inProduction,
      languages,
      lastAirDate,
      lastEpisodeToAir,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originCountry,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      seasons,
      status,
      tagline,
      type,
      voteAverage,
      voteCount,
    ];
  }
}




