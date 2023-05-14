import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/detail_season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/entities/tv_episode.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> getPopularTvs();
  Future<Either<Failure, List<Tv>>> getNowAiringTvs();
  Future<Either<Failure, List<Tv>>> getTopRatedTvs();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tv>>> getTvsRecommendation(int id);
  Future<Either<Failure, DetailSeason>> getTvDetailSeason(
      int tvId, int seasonNumber);
  Future<Either<Failure, TvEpisode>> getTvDetailEpisode(
      int tvId, int seasonNumber, int episodeNumber);
  
  Future<Either<Failure, String>> saveWatchlist(TvDetail tv);
  Future<Either<Failure, String>> removeWatchlist(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getTvsWatchlist();
}
