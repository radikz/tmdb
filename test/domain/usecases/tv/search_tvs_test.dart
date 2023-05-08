import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvs searchTvs;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    searchTvs = SearchTvs(repository);
  });

  final listTv = <Tv>[testTv];

  test('get list tv', () async {
    when(repository.searchTvs("tv")).thenAnswer((_) async => Right(listTv));

    final result = await searchTvs.execute("tv");

    expect(result, Right(listTv));
  });
}
