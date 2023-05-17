import 'package:flutter_test/flutter_test.dart';
import 'package:tv/presentation/tv/bloc/episode_detail/episode_detail_tv_bloc.dart';

void main() {
  test('supports value comparison', () {
    expect(const FetchEpisodeDetailTv(id: 1, seasonNumber: 1, episodeNumber: 1), const FetchEpisodeDetailTv(id: 1, seasonNumber: 1, episodeNumber: 1));
  });
}