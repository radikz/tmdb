
import 'package:core/tv/data/models/tv_model.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:tv/data/models/detail_season_model.dart';
import 'package:tv/data/models/season_model.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_episode_model.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/detail_season.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);



final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTv = Tv(
    firstAirDate: DateTime(2023, 2, 2).toIso8601String(),
    genreIds: [],
    id: 1,
    name: "name",
    originCountry: [],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 9,
    voteAverage: 9,
    voteCount: 9);

final testTvModel = TvModel(
    firstAirDate: DateTime(2023, 2, 2).toIso8601String(),
    genreIds: [],
    id: 1,
    name: "name",
    originCountry: [],
    originalLanguage: "originalLanguage",
    originalName: "originalName",
    overview: "overview",
    popularity: 9,
    voteAverage: 9,
    voteCount: 9);

final testTvEpisode = TvEpisode(
    id: 1,
    name: "name",
    overview: "overview",
    voteAverage: 9,
    voteCount: 9,
    airDate: DateTime(2023, 2, 2),
    episodeNumber: 1,
    productionCode: "productionCode",
    seasonNumber: 1,
    stillPath: "stillPath");

final testTvEpisodeModel = TvEpisodeModel(
    id: 1,
    name: "name",
    overview: "overview",
    voteAverage: 9,
    voteCount: 9,
    airDate: DateTime(2023, 2, 2),
    episodeNumber: 1,
    productionCode: "productionCode",
    seasonNumber: 1,
    stillPath: "stillPath");

final testSeason = Season(
    airDate: DateTime(2023, 2, 2),
    episodeCount: 3,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1);

final testSeasonModel = SeasonModel(
    airDate: DateTime(2023, 2, 2),
    episodeCount: 3,
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1);

final testDetailSeason = DetailSeason(
    airDate: DateTime(2023, 2, 2),
    episodes: [testTvEpisode],
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1);

final testDetailSeasonModel = DetailSeasonModel(
    airDate: DateTime(2023, 2, 2),
    episodes: [testTvEpisodeModel],
    id: 1,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1);

final testTvDetail = TvDetail(
    backdropPath: "backdropPath",
    episodeRunTime: [],
    firstAirDate: DateTime(2023, 2, 2),
    genres: [],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: [],
    lastAirDate: DateTime(2023, 2, 2),
    lastEpisodeToAir: testTvEpisode,
    name: "name",
    numberOfEpisodes: 9,
    numberOfSeasons: 9,
    originCountry: [],
    originalLanguage: "",
    originalName: "originalName",
    overview: "overview",
    popularity: 9,
    posterPath: "posterPath",
    seasons: [testSeason],
    status: "status",
    tagline: "",
    type: "type",
    voteAverage: 9,
    voteCount: 90);

final testTvModelDetail = TvDetailModel(
    backdropPath: "backdropPath",
    episodeRunTime: [],
    firstAirDate: DateTime(2023, 2, 2),
    genres: [],
    homepage: "homepage",
    id: 1,
    inProduction: false,
    languages: [],
    lastAirDate: DateTime(2023, 2, 2),
    lastEpisodeToAir: testTvEpisodeModel,
    name: "name",
    numberOfEpisodes: 9,
    numberOfSeasons: 9,
    originCountry: [],
    originalLanguage: "",
    originalName: "originalName",
    overview: "overview",
    popularity: 9,
    posterPath: "posterPath",
    seasons: [testSeasonModel],
    status: "status",
    tagline: "",
    type: "type",
    voteAverage: 9,
    voteCount: 90);
