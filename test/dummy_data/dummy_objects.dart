import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
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

final testTvEpisode = TvEpisode(
    id: 1,
    name: "name",
    overview: "overview",
    voteAverage: 9,
    voteCount: 9,
    airDate: DateTime(2023, 2, 2),
    episodeNumber: 3,
    productionCode: "productionCode",
    seasonNumber: 9,
    stillPath: "stillPath");

final season = Season(
    airDate: DateTime(2023, 2, 2),
    episodeCount: 3,
    id: 3,
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 3);

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
    seasons: [season],
    status: "status",
    tagline: "",
    type: "type",
    voteAverage: 9,
    voteCount: 90);
