import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';

import '../../../helper/dummy.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchWatchlistMovie(), FetchWatchlistMovie());
    expect(FetchWatchlistStatusMovie(1), FetchWatchlistStatusMovie(1));
    expect(RemoveWatchlistMovie(testMovieDetail),
        RemoveWatchlistMovie(testMovieDetail));
    expect(
        AddWatchlistMovie(testMovieDetail), AddWatchlistMovie(testMovieDetail));
  });
}
