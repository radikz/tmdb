import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/bloc/now_playing/bloc/now_playing_movie_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(FetchNowPlayingMovie(), FetchNowPlayingMovie());
  });
}
