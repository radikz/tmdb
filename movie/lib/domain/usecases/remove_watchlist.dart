import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
