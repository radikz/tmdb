import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class GetNowAiringTvs {
  final TvRepository repository;

  GetNowAiringTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getNowAiringTvs();
  }
}
