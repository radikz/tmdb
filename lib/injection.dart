import 'package:core/search/data/datasources/search_remote_datasource.dart';
import 'package:core/search/data/repositories/search_repository_impl.dart';
import 'package:core/search/domain/repositories/search_repository.dart';
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
import 'package:movie/presentation/provider/movie_detail_notifier.dart';
import 'package:movie/presentation/provider/movie_list_notifier.dart';
import 'package:movie/presentation/provider/popular_movies_notifier.dart';
import 'package:movie/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie/presentation/provider/watchlist_movie_notifier.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'package:search/presentation/bloc/movie/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv/tv_search_bloc.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';
import 'package:search/presentation/provider/tv_search_notifier.dart';
import 'package:http/http.dart' as http;
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
import 'package:tv/presentation/tv/provider/airing_now_tvs_notifier.dart';
import 'package:tv/presentation/tv/provider/episode_detail_tv_notifier.dart';
import 'package:tv/presentation/tv/provider/popular_tvs_notifier.dart';
import 'package:tv/presentation/tv/provider/season_detail_tv_notifier.dart';
import 'package:tv/presentation/tv/provider/top_rated_tvs_notifier.dart';
import 'package:tv/presentation/tv/provider/tv_detail_notifier.dart';
import 'package:tv/presentation/tv/provider/tv_list_notifier.dart';
import 'package:tv/presentation/tv/provider/watchlist_tv_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  /// Tv Notifier
  locator.registerFactory(() => TvListNotifier(
      getNowAiringTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator()));
  locator.registerFactory(() => TvDetailNotifier(
        getTvDetail: locator(),
        getTvWatchlistStatus: locator(),
        getTvsRecommendation: locator(),
        removeWatchlistTv: locator(),
        saveWatchlistTv: locator(),
      ));
  locator.registerFactory(
    () => AiringNowTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSearchNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => EpisodeDetailTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => SeasonDetailTvNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvNotifier(
      locator(),
    ),
  );
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
  locator.registerLazySingleton(() => http.Client());

  /// search
  locator.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: locator()));
}
