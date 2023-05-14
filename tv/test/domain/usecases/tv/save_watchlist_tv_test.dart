import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/tv/save_watchlist_tv.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late SaveWatchlistTv saveWatchlistTv;
  late MockTvRepository repository;

  setUp(() {
    repository = MockTvRepository();
    saveWatchlistTv = SaveWatchlistTv(repository);
  });

  test('save watchlist tv', () async {
    when(repository.saveWatchlist(testTvDetail))
        .thenAnswer((_) async => Right("Added to Watchlist"));

    final result = await saveWatchlistTv.execute(testTvDetail);

    expect(result, Right("Added to Watchlist"));
  });
}
