import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:tv/domain/entities/detail_season.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTvDetailSeason {
  final TvRepository repository;

  GetTvDetailSeason(this.repository);

  Future<Either<Failure, DetailSeason>> execute(int tvId, int seasonNumber) {
    return repository.getTvDetailSeason(tvId, seasonNumber);
  }
}
