import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetWatchlistTvs {
  final TvRepository repository;

  GetWatchlistTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getTvsWatchlist();
  }
}
