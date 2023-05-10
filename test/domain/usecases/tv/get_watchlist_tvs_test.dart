import 'package:dartz/dartz.dart';
import 'package:core/tv/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvs getWatchlistTvs;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    getWatchlistTvs = GetWatchlistTvs(repository);
  });

  final listTv = <Tv>[testTv];

  test('get list tv', () async {
    when(repository.getTvsWatchlist()).thenAnswer((_) async => Right(listTv));

    final result = await getWatchlistTvs.execute();

    expect(result, Right(listTv));
  });
}
