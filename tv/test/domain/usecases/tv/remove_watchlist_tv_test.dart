import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist_tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveWatchlistTv removeWatchlistTv;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    removeWatchlistTv = RemoveWatchlistTv(repository);
  });

  test('remove watchlist tv', () async {
    when(repository.removeWatchlist(testTvDetail))
        .thenAnswer((_) async => const Right("Removed from watchlist"));

    final result = await removeWatchlistTv.execute(testTvDetail);

    expect(result, const Right("Removed from watchlist"));
  });
}
