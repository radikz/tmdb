import 'package:core/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/movie/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_movies.dart';

import 'search_movies_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  late SearchMovies usecase;
  late MockSearchRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockSearchRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  final tMovies = <Movie>[];
  final tQuery = 'Spiderman';

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockMovieRepository.searchMovies(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tMovies));
  });
}
