import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/watchlist/watchlist_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchWatchlistTv(), FetchWatchlistTv());
    expect(FetchWatchlistStatusTv(1), FetchWatchlistStatusTv(1));
    expect(RemoveWatchlistTvEvent(testTvDetail),
        RemoveWatchlistTvEvent(testTvDetail));
    expect(AddWatchlistTv(testTvDetail), AddWatchlistTv(testTvDetail));
  });
}
