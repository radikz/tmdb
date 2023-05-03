import 'package:ditonton/data/models/detail_season_model.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_episode_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/detail_season.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

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

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

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
