import 'package:core/search/domain/repositories/search_repository.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';

class SearchTvs {
  final SearchRepository repository;

  SearchTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvs(query);
  }
}
