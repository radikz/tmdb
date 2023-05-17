import 'dart:io';

import 'package:core/search/data/datasources/search_remote_datasource.dart';
import 'package:core/search/data/repositories/search_repository_impl.dart';
import 'package:core/search/domain/repositories/search_repository.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';
import 'package:movie/data/datasources/db/database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tv/data/datasources/db/database_helper_tv.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/repositories/tv_repository_impl.dart';
import 'package:tv/domain/repositories/tv_repository.dart';
import 'package:tv/domain/usecases/tv/get_now_airing_tvs.dart';
import 'package:tv/domain/usecases/tv/get_popular_tvs.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tvs.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_episode.dart';
import 'package:tv/domain/usecases/tv/get_tv_detail_season.dart';
import 'package:tv/domain/usecases/tv/get_tv_watchlist_status.dart';
import 'package:tv/domain/usecases/tv/get_tvs_recommendation.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:tv/presentation/tv/bloc/airing_now/airing_now_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/episode_detail/episode_detail_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/popular/popular_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/recommendation/recommendation_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/season_detail/season_detail_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:tv/presentation/tv/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

Future<SecurityContext> get globalContext async {
  final sslCert = await rootBundle.load('assets/tmdb-cert.cer');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
  return securityContext;
}

Future<void> init() async {
  locator.registerFactory(() => MovieSearchBloc(locator()));
  locator.registerFactory(() => TvSearchBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(() => WatchlistMovieBloc(
      getWatchListStatus: locator(),
      getWatchlistMovies: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator()));
  locator.registerFactory(() => MovieDetailBloc(locator()));

  locator.registerFactory(() => TopRatedTvBloc(locator()));
  locator.registerFactory(() => PopularTvBloc(locator()));
  locator.registerFactory(() => AiringNowTvBloc(locator()));
  locator.registerFactory(() => RecommendationTvBloc(locator()));
  locator.registerFactory(() => WatchlistTvBloc(
      getWatchListStatus: locator(),
      getWatchlistTvs: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => SeasonDetailTvBloc(locator()));
  locator.registerFactory(() => EpisodeDetailTvBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // tv use case
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetNowAiringTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvsRecommendation(locator()));
  locator.registerLazySingleton(() => GetTvDetailEpisode(locator()));
  locator.registerLazySingleton(() => GetTvDetailSeason(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
      localDataSource: locator(), remoteDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton(() => DatabaseHelperTv());

  // external
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;
  locator.registerLazySingleton(() => IOClient(client));

  /// search
  locator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: locator()));
}
