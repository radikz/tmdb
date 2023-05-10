import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:core/utils/failure.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
