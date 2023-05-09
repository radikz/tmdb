import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvDetailEpisode {
  final TvRepository repository;

  GetTvDetailEpisode(this.repository);

  Future<Either<Failure, TvEpisode>> execute(
      int tvId, int seasonNumber, int episodeNumber) {
    return repository.getTvDetailEpisode(tvId, seasonNumber, episodeNumber);
  }
}
