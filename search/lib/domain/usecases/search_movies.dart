import 'package:core/movie/domain/entities/movie.dart';
import 'package:core/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

class SearchMovies {
  final SearchRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute(String query) {
    return repository.searchMovies(query);
  }
}
