import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/detail_season.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvDetailSeason {
  final TvRepository repository;

  GetTvDetailSeason(this.repository);

  Future<Either<Failure, DetailSeason>> execute(int, tvId, int seasonNumber) {
    return repository.getTvDetailSeason(tvId, seasonNumber);
  }
}
