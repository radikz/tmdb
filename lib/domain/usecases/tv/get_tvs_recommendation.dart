import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvsRecommendation {
  final TvRepository repository;

  GetTvsRecommendation(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return repository.getTvsRecommendation(id);
  }
}
