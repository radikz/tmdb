import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/tv_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/domain/entities/detail_season.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvLocalDataSource localDataSource;
  final TvRemoteDataSource remoteDataSource;

  TvRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Tv>>> getNowAiringTvs() {
    // TODO: implement getNowAiringTvs
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTvs() {
    // TODO: implement getPopularTvs
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTvs() {
    // TODO: implement getTopRatedTvs
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) {
    // TODO: implement getTvDetail
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TvEpisode>> getTvDetailEpisode(int tvId, int seasonNumber, int episodeNumber) {
    // TODO: implement getTvDetailEpisode
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, DetailSeason>> getTvDetailSeason(int tvId, int seasonNumber) {
    // TODO: implement getTvDetailSeason
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvsRecommendation(int id) {
    // TODO: implement getTvsRecommendation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvsWatchlist() {
    // TODO: implement getTvsWatchlist
    throw UnimplementedError();
  }

  @override
  Future<bool> isAddedToWatchlist(int id) {
    // TODO: implement isAddedToWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv) {
    // TODO: implement removeWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv) {
    // TODO: implement saveWatchlist
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTvs(String query) {
    // TODO: implement searchTvs
    throw UnimplementedError();
  }
}
