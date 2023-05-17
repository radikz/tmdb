import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movie_bloc.dart';

import '../../../helper/dummy.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchWatchlistMovie(), FetchWatchlistMovie());
    expect(
        const FetchWatchlistStatusMovie(1), const FetchWatchlistStatusMovie(1));
    expect(const RemoveWatchlistMovie(testMovieDetail),
        const RemoveWatchlistMovie(testMovieDetail));
    expect(const AddWatchlistMovie(testMovieDetail),
        const AddWatchlistMovie(testMovieDetail));
  });
}
