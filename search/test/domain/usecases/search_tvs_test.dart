import 'package:core/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:mockito/annotations.dart';
import 'package:search/domain/usecases/search_tvs.dart';
import 'search_movies_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([SearchRepository])
void main() {
  late SearchTvs searchTvs;
  late MockSearchRepository repository;

  setUp(() {
    repository = MockSearchRepository();
    searchTvs = SearchTvs(repository);
  });

  final testTv = Tv(
      firstAirDate: DateTime(2023, 2, 2).toIso8601String(),
      genreIds: const [],
      id: 1,
      name: "name",
      originCountry: const [],
      originalLanguage: "originalLanguage",
      originalName: "originalName",
      overview: "overview",
      popularity: 9,
      voteAverage: 9,
      voteCount: 9);

  final listTv = <Tv>[testTv];

  test('get list tv', () async {
    when(repository.searchTvs("tv")).thenAnswer((_) async => Right(listTv));

    final result = await searchTvs.execute("tv");

    expect(result, Right(listTv));
  });
}
